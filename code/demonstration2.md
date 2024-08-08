terraform state list

terraform state show 'module.test-vm.yandex_compute_instance.vm[0]' | grep 'id'
terraform state show 'module.test-vm.data.yandex_compute_image.my_image' | grep 'id'
terraform state show 'module.vpc_dev.yandex_vpc_network.vpc_net' | grep 'id'
terraform state show 'module.vpc_dev.yandex_vpc_subnet.vpc_subnet' | grep 'id'

terraform state rm 'module.vpc_dev.yandex_vpc_network.vpc_net'
terraform state rm 'module.vpc_dev.yandex_vpc_subnet.vpc_subnet'
terraform state rm 'module.test-vm.yandex_compute_instance.vm[0]'

terraform import module.test-vm.yandex_compute_instance.vm[0] fhmffr8bhtccqp832na4
terraform import module.vpc_dev.yandex_vpc_network.vpc_net enpa0k6glu9f5rhruha1
terraform import module.vpc_dev.yandex_vpc_subnet.vpc_subnet e9bg2n8ggp3h0bn4idum







terraform state show 'yandex_vpc_network.develop'

terraform state show 'module.test-vm.yandex_compute_instance.vm[0]'

terraform apply -target module.test-vm

terraform apply -target module.test-vm -replace='module.test-vm.yandex_compute_instance.vm[0]'

terraform state show 'module.test-vm.yandex_compute_instance.vm[0]' | grep 'id'

terraform state rm 'module.test-vm.yandex_compute_instance.vm[0]'

terraform import 'module.test-vm.yandex_compute_instance.vm[0]' fhm1g61rfod251rpdeqg #<VM.ID>

module.vpc_dev.yandex_vpc_network.vpc_net: Creating...
module.vpc_dev.yandex_vpc_network.vpc_net: Creation complete after 2s [id=enp0qavlup1irega1m7u]
module.vpc_dev.yandex_vpc_subnet.vpc_subnet: Creating...
module.vpc_dev.yandex_vpc_subnet.vpc_subnet: Creation complete after 0s [id=e9b73b003q6i8m9hrtgv]
module.test-vm.yandex_compute_instance.vm[0]: Creating...
module.test-vm.yandex_compute_instance.vm[0]: Still creating... [10s elapsed]
module.test-vm.yandex_compute_instance.vm[0]: Still creating... [20s elapsed]
module.test-vm.yandex_compute_instance.vm[0]: Still creating... [30s elapsed]
module.test-vm.yandex_compute_instance.vm[0]: Still creating... [40s elapsed]
module.test-vm.yandex_compute_instance.vm[0]: Still creating... [50s elapsed]
module.test-vm.yandex_compute_instance.vm[0]: Creation complete after 57s [id=fhmt0k3e82pp04vpa26l]