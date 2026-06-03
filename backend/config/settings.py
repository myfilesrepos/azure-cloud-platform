import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

# ========================
# HELPER (READ FROM FILE)
# ========================
def read_secret(path, default=None):
    try:
        with open(path, "r") as f:
            return f.read().strip()
    except FileNotFoundError:
        return default

# ========================
# SECURITY
# ========================
SECRET_KEY = read_secret("/mnt/secrets/SECRET_KEY", "unsafe-key")
DEBUG = os.environ.get("DEBUG", "False") == "True"

# For production, replace "*" with your domains or use environment variable
ALLOWED_HOSTS = os.environ.get("ALLOWED_HOSTS", "*").split(",")

# ========================
# APPLICATIONS
# ========================
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    "rest_framework",
    "corsheaders",
    "todo",
]

MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

# ========================
# CORS
# ========================
CORS_ALLOW_ALL_ORIGINS = True

# ========================
# URLS & TEMPLATES
# ========================
ROOT_URLCONF = 'config.urls'
WSGI_APPLICATION = 'config.wsgi.application'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# ========================
# DATABASE (AZURE POSTGRES)
# ========================
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": read_secret("/mnt/secrets/DB_NAME"),
        "USER": read_secret("/mnt/secrets/DB_USER"),
        "PASSWORD": read_secret("/mnt/secrets/DB_PASSWORD"),
        "HOST": read_secret("/mnt/secrets/DB_HOST"),
        "PORT": "5432",
        "OPTIONS": {
            "sslmode": "require",
        },
    }
}

# ========================
# STATIC FILES
# ========================
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / "staticfiles"

# ========================
# SECURITY HARDENING
# ========================
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True

# ========================
# AUTHENTICATION VALIDATORS
# ========================
AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',},
]

# ========================
# INTERNATIONALIZATION
# ========================
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# ========================
# DEFAULT PRIMARY KEY FIELD TYPE
# ========================
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
