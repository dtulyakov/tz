# tz
Для установки lxc окружения, удаления всех старых контейнеров и создания новых 3х бекенд и 2 nginx балансеров

```
#!bash

ansible-playbook playbooks/lxc.yml --ask-pass --ask-sudo-pass -l lxc
```

для настройки пхп беков

```
#!bash

ansible-playbook playbooks/phpnode.yml --ask-pass --ask-sudo-pass -l php
```

для настройки самих балансеров и добавлении новых в список балансировки следует передать их на вход через переменную

```
#!bash

ansible-playbook playbooks/nginx.yml --ask-pass --ask-sudo-pass -l nginx  --extra-vars '{"bservers":"server php-0;\n\tserver php-1;\n\tserver php-2"}'
```
