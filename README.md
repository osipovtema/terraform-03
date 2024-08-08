# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

---

## Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote-модуля.
2. Создайте одну ВМ, используя этот модуль. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
   Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды `sudo nginx -t`.

## Ответ:

- Создал одну ВМ `instance_count = 1`.
- В файле cloud-init.yml использовал переменную для SSH-ключа.
- Передал SSH-ключ в функцию template_file в блоке vars ={} согласно примеру.
- Добавил в файл cloud-init.yml установку nginx в packages.

![vers](img/1_1.png)

---

## Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: `ru-central1-a`.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev.
6. Сгенерируйте документацию к модулю с помощью terraform-docs.

Пример вызова

```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```

## Ответ:

- Локальный модуль написан.
- Передал в модуль переменные с названием сети, zone и v4_cidr_blocks.
- Пример: > module.vpc_dev:

![vers](img/2_1.png)

- Передал необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
- Пример: > module.vpc_dev.

![vers](img/2_2.png)

- Сгенерировал документацию к модулю с помощью terraform-docs согласно [**документации**](https://terraform-docs.io/user-guide/installation/). docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs > doc.md:

![vers](img/2_3.png)

![vers](img/2_4.png)

---

## Задание 3

1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Изменений быть не должно.
   Приложите список выполненных команд и скриншоты процессы.

## Ответ:

- terraform state list
- terraform state show 'module.test-vm.data.yandex_compute_image.my_image' | grep 'id'
- terraform state show 'module.test-vm.yandex_compute_instance.vm[0]' | grep 'id'
- terraform state show 'module.vpc_dev.yandex_vpc_network.vpc_net' | grep 'id'
- terraform state show 'module.vpc_dev.yandex_vpc_subnet.vpc_subnet' | grep 'id'

![vers](img/3_1.png)

- terraform state rm 'module.vpc_dev.yandex_vpc_network.vpc_net'
- terraform state rm 'module.vpc_dev.yandex_vpc_subnet.vpc_subnet'
- Можно так: - terraform state rm module.vpc_dev

![vers](img/3_2.png)

- terraform state rm 'module.test-vm.yandex_compute_instance.vm[0]'
- terraform state rm 'module.test-vm.data.yandex_compute_image.my_image'
- Можно так: - terraform state rm module.test-vm

![vers](img/3_3.png)

- terraform import module.test-vm.yandex_compute_instance.vm[0] fhm179t7cs8jh1ms86af
- terraform import module.vpc_dev.yandex_vpc_network.vpc_net enpr7fvf5v7ot78vh7o6
- terraform import module.vpc_dev.yandex_vpc_subnet.vpc_subnet e9b0cjdrmshpg2kch0nn

![vers](img/3_4.png)

![vers](img/3_5.png)

![vers](img/3_6.png)

---

## Задание 4\*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.

Пример вызова

```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

## Ответ:

![vers](img/4_1.png)

![vers](img/4_2.png)

---

## Задание 5\* (необязательное)

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster: передайте имя кластера и id сети.
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user: передайте имя базы данных, имя пользователя и id кластера при вызове модуля.
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2-х серверов.
4. Предоставьте план выполнения и по возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого. Используйте минимальную конфигурацию.

## Ответ:

![vers](img/5_1.png)

![vers](img/5_2.png)

![vers](img/5_3.png)

![vers](img/5_4.png)

![vers](img/5_5.png)

![vers](img/5_6.png)

![vers](img/5_7.png)

![vers](img/5_8.png)

![vers](img/5_9.png)

![vers](img/5_10.png)

---

## Задание 6\* (необязательное)

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education".
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create
   Path: example  
   secret data key: test
   secret data value: congrats!
4. Считайте этот секрет с помощью terraform и выведите его в output по примеру:

```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
}

Можно обратиться не к словарю, а конкретному ключу:
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```

5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform.

## Ответ:

![vers](img/6_1.png)
