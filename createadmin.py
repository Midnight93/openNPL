#!/usr/bin/env python

import django
django.setup()
from django.contrib.auth.models import User
User.objects.all().delete()
User.objects.create_superuser('admin', 'admin@example.com', 'admin')