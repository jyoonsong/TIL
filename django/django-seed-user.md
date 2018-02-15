## dJango 시드 유저 비밀번호 변경

```shell
In [1]: from django.contrib.auth import get_user_model

In [2]: User = get_user_model()

In [3]: User.objects.all()
Out[3]: <QuerySet [<User: admin@admin.com>]>

In [4]: User.objects.all()[0].type
Out[4]: 'i'

In [5]: User.objects.all()[0].password
Out[5]: '123123'

In [6]: User.objects.all()[0].set_password('123123')

In [7]: user = User.objects.all()[0].set_password('123123')

In [8]: user.save()
---------------------------------------------------------------------------
AttributeError                            Traceback (most recent call last)
<ipython-input-8-87db4c969fb8> in <module>()
----> 1 user.save()

AttributeError: 'NoneType' object has no attribute 'save'

In [9]: user = User.objects.all()[0]

In [10]: user.set_password('123123')

In [11]: user.save()

In [12]: user.password
Out[12]: 'pbkdf2_sha256$36000$rQtYQ6Dq5Ubt$IXZeY68+Hv0D+mq01biv1H0/iKw6bbyYT4b/QzLdCco='

In [13]: exit
```

