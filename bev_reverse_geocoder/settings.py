"""
Django settings for bev_reverse_geocoder project.

For more information on this file, see
https://docs.djangoproject.com/en/1.7/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.7/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
import environ

BASE_DIR = os.path.dirname(os.path.dirname(__file__))

env = environ.Env()
environ.Env.read_env(os.path.join(BASE_DIR, '.env')) # reading .env file


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.7/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '(ync6bf)uc)9_-u-lz75ql-9j2a(+#he5s_0#*7v$z00&-_pyh'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = env.bool('DEBUG', default=False)

ALLOWED_HOSTS = ['*']

# Application definition

INSTALLED_APPS = (
    'django.contrib.staticfiles',
    'bev_reverse_geocoder_api',
)

ROOT_URLCONF = 'bev_reverse_geocoder.urls'

WSGI_APPLICATION = 'bev_reverse_geocoder.wsgi.application'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'APP_DIRS': True
    }
]

# Database
# https://docs.djangoproject.com/en/1.7/ref/settings/#databases

DATABASES = {}

# Internationalization
# https://docs.djangoproject.com/en/1.7/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.7/howto/static-files/

STATIC_URL = '/static/'

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static/'),
]
