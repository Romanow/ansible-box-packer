# Vagrant box

Создание образа Ubuntu 22.04 LTS для `Virtualbox`:

* с пользователем `ansible`/`root` без запроса пароля для sudo;
* предустановленными пакетами:
    *

## Сборка

Получить токен [Vagrant Cloud](https://app.vagrantup.com/) -> `Profile` -> `Security`.

```shell
$ echo 'cloud_token = "<vagrant cloud token>"' > vars.pkrvars.hcl

$ packer build -var-file=vars.pkrvars.hcl template.pkr.hcl
```

Собранный образ находится в папке `builds/`, и опубликуется в
репозиторий [ansible-box](https://app.vagrantup.com/romanow/boxes/ansible-box).

## Проверка

Для проверки можно запустить [vagrant](vagrant/Vagrantfile):

```shell
$ vagrant upl
```