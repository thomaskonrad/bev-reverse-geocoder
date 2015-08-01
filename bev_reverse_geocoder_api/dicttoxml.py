from xml.dom.minidom import Document


class DictToXML(object):
    default_list_item_name = "item"

    def __init__(self, structure, list_mappings={}):
        self.doc = Document()

        if len(structure) == 1:
            rootName = str(list(structure.keys())[0])
            self.root = self.doc.createElement(rootName)

            self.list_mappings = list_mappings

            self.doc.appendChild(self.root)
            self.build(self.root, structure[rootName])

    def build(self, father, structure):
        if type(structure) == dict:
            for k in structure:
                tag = self.doc.createElement(k)
                father.appendChild(tag)
                self.build(tag, structure[k])
        elif type(structure) == list:
            tag_name = self.default_list_item_name

            if father.tagName in self.list_mappings:
                tag_name = self.list_mappings[father.tagName]

            for l in structure:
                tag = self.doc.createElement(tag_name)
                self.build(tag, l)
                father.appendChild(tag)
        else:
            data = str(structure)
            tag = self.doc.createTextNode(data)
            father.appendChild(tag)

    def display(self):
        print(self.doc.toprettyxml(indent="  "))

    def get_string(self):
        return self.doc.toprettyxml(indent="  ")


if __name__ == '__main__':
    example = {'sibling': {'couple': {'mother': 'mom', 'father': 'dad', 'children': [{'child': 'foo'},
                                                                                      {'child': 'bar'}]}}}
    xml = DictToXML(example)
    xml.display()
