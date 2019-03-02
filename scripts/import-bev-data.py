#!/usr/bin/env python3
import argparse
import psycopg2
import sys
import os.path
import csv


def is_float(value):
    try:
        float(value)
        return True
    except ValueError:
        return False


def main():
    parser = argparse.ArgumentParser(description="Imports the Austrian BEV address data.",
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-H", "--hostname", dest="hostname", required=False, help="Host name or IP Address")
    parser.add_argument("-d", "--database", dest="database", default="gis", help="The name of the database")
    parser.add_argument("-t", "--table", dest="table", default="bev_addresses",
                        help="The database table to insert the data")
    parser.add_argument("-u", "--user", dest="user", required=False, help="The database user")
    parser.add_argument("-p", "--password", dest="password", required=False, help="The database password")
    parser.add_argument("-f", "--file", dest="file", required=True, help="The file to read from")
    parser.add_argument("-D", "--date", dest="date", required=True,
                        help="The date the data is from in the format '2016-10-02'.")
    args = parser.parse_args()

    # Try to connect
    try:
        conn = psycopg2.connect(
            host=args.hostname,
            database=args.database,
            user=args.user,
            password=args.password
        )
    except Exception as e:
        print("I am unable to connect to the database (%s)." % e.message)
        sys.exit(1)

    cursor = conn.cursor()

    if os.path.isfile(args.file):
        # Insert the date
        try:
            statement = "TRUNCATE TABLE bev_date"
            cursor.execute(statement)
            statement = "INSERT INTO bev_date VALUES(%s)"
            cursor.execute(statement, (args.date,))
        except:
            print("Unable to insert the date. Is the format correct?")
            sys.exit(1)

        # Drop all data
        try:
            statement = "TRUNCATE TABLE " + args.table
            cursor.execute(statement)
        except Exception as e:
            print("Could not drop table data (%s)!" % e)
            sys.exit(1)

        # Count the lines in the file
        with open(args.file) as myfile:
            total_addresses = sum(1 for line in myfile if line.rstrip('\n')) - 1

        # Iterate through the file and insert rows.
        with open(args.file) as f:
            # Skip the first line as it contains only the header.
            next(f)

            previous_percentage = 0
            i = 0

            for line in csv.reader(f, quotechar='"', delimiter=";", quoting=csv.QUOTE_MINIMAL):
                # Print the percentage. Taken from https://github.com/scubbx/convert-bev-address-data-python/blob/master/convert-addresses.py
                current_percentage = round(float(i) / total_addresses * 100, 2)
                if current_percentage != previous_percentage:
                    # Draw a nice progess bar
                    sys.stdout.write("\r{} %   ".format(str(current_percentage).ljust(6)))
                    sys.stdout.write("[{}] ".format(('#' * int(current_percentage / 2)).ljust(50)))
                    sys.stdout.flush()
                    previous_percentage = current_percentage

                i += 1

                statement = "INSERT INTO " + \
                            args.table + \
                            "(municipality, locality, postcode, street, house_number, house_name, address_type, point)" \
                            "VALUES (%s, %s, %s, %s, %s, %s, 'unknown', ST_SetSRID(ST_MakePoint(%s, %s),4326))"

                # Do some basic data validation.
                if len(line) == 19 and is_float(line[8]) and is_float(line[9]):
                    try:
                        cursor.execute(statement, (
                            line[0], line[1], int(line[2]), line[3], line[6], line[7], line[8], line[9],)
                                       )
                    except Exception as e:
                        print("I can't insert the row '%s'! The exception was: %s" % (line, e,))
                        conn.rollback()
                        conn.close()
                        sys.exit(1)
                else:
                    print(
                        "There is something wrong with this line: '%s'. Please check if the column count is 8 and the data types are correct." % line)

        try:
            # Execute the data correction SQL script.
            print("Executing data correction script.")
            cursor.execute(open("correct-data.sql", "r").read())
        except Exception as e:
            print("Cannot set the address type! The exception was: %s" % (e,))
            conn.rollback()
            conn.close()
            sys.exit(1)
    else:
        print("Unable to open the file '%s' as it does not exist." % args.file)

    # Commit all changes and close the connection.
    conn.commit()
    conn.close()


if __name__ == "__main__":
    main()
