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

