variable "region" {
  type        = string
  description = "Região da AWS onde os recursos serão provisionados."
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster ECS que hospedará o serviço."
}

variable "service_name" {
  type        = string
  description = "Nome do serviço que será usado dentro do cluster."
}

variable "service_port" {
  type        = number
  description = "Porta TCP na qual o serviço aceitará tráfego."
}

variable "service_cpu" {
  type        = number
  description = "Quantidade de CPU reservada para o serviço, em unidades definidas pela AWS."
}

variable "service_memory" {
  type        = number
  description = "Quantidade de memória reservada para o serviço, em megabytes."
}

variable "service_healthcheck" {
  type        = map(any)
  description = "Configurações do health check para o serviço, como caminho e protocolo."
}

variable "service_launch_type" {
  description = "Configuração dos Launch Types pelos capacity providers disponíveis no cluster"
  type = list(object({
    capacity_provider = string
    weight            = number
  }))
}

variable "service_task_count" {
  type        = number
  description = "Número de tarefas que o serviço deve manter em execução simultaneamente."
}

variable "service_hosts" {
  type        = list(string)
  description = "Lista de endereços ou nomes de host atribuídos ao serviço para balanceamento de carga ou exposição."
}

variable "ssm_vpc_id" {
  type        = string
  description = "ID do VPC armazenado no AWS Systems Manager (SSM) onde o serviço será implantado."
}

variable "ssm_listener" {
  type        = string
  description = "ARN do listener de um Application Load Balancer (ALB), armazenado no AWS SSM, que será usado pelo serviço."
}

variable "ssm_private_subnet_1" {
  type        = string
  description = "ID da primeira subnet privada, armazenado no AWS SSM, onde o serviço será implantado."
}

variable "ssm_private_subnet_2" {
  type        = string
  description = "ID da segunda subnet privada, armazenado no AWS SSM, para implantação do serviço."
}

variable "ssm_private_subnet_3" {
  type        = string
  description = "ID da terceira subnet privada, armazenado no AWS SSM, usada para implantação do serviço."
}

variable "ssm_alb" {
  type        = string
  description = ""
}

variable "environment_variables" {
  type        = list(map(string))
  description = "Lista de variáveis de ambiente que serão passadas às tarefas do serviço."
}

variable "capabilities" {
  type        = list(string)
  description = "Lista de capacidades especiais necessárias para o serviço, como 'SYS_ADMIN' para determinados privilégios de sistema."
}

### Autoscaling

variable "scale_type" {
  type        = string
  description = "Tipo de escalabilidade, como 'cpu', 'cpu_tracking' ou 'requests_tracking'."
  default     = null
}

variable "task_mininum" {
  type        = number
  description = "Número mínimo de tarefas que devem ser executadas pelo serviço."
  default     = 3
}

variable "task_maximum" {
  type        = number
  description = "Número máximo de tarefas que podem ser executadas pelo serviço."
  default     = 10
}

### Autoscaling de CPU - OUT

variable "scale_out_cpu_threshold" {
  type        = number
  description = "Valor de limiar de utilização de CPU que, quando excedido, aciona uma ação de escala para cima, em percentual."
  default     = 80
}

variable "scale_out_adjustment" {
  type        = number
  description = "Quantidade de tarefas para aumentar durante uma ação de escala para cima."
  default     = 1
}

variable "scale_out_comparison_operator" {
  type        = string
  description = "Operador de comparação usado para a condição de escala para cima, como 'GreaterThanOrEqualToThreshold'."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "scale_out_statistic" {
  type        = string
  description = "Estatística usada para a condição de escala para cima, como 'Average' ou 'Sum'."
  default     = "Average"
}

variable "scale_out_period" {
  type        = number
  description = "Duração do período de avaliação para escala para cima, em segundos."
  default     = 60
}

variable "scale_out_evaluation_periods" {
  type        = number
  description = "Número de períodos de avaliação necessários para acionar uma escala para cima."
  default     = 2
}

variable "scale_out_cooldown" {
  type        = number
  description = "Período de cooldown após uma ação de escala para cima, em segundos."
  default     = 60
}

### Autoscaling de CPU - IN

variable "scale_in_cpu_threshold" {
  type        = number
  description = "Valor de limiar de utilização de CPU que, quando abaixo, aciona uma ação de escala para baixo, em percentual."
  default     = 30
}

variable "scale_in_adjustment" {
  type        = number
  description = "Quantidade de tarefas para reduzir durante uma ação de escala para baixo."
  default     = -1
}

variable "scale_in_comparison_operator" {
  type        = string
  description = "Operador de comparação usado para a condição de escala para baixo, como 'LessThanOrEqualToThreshold'."
  default     = "LessThanOrEqualToThreshold"
}

variable "scale_in_statistic" {
  type        = string
  description = "Estatística usada para a condição de escala para baixo, como 'Average' ou 'Sum'."
  default     = "Average"
}

variable "scale_in_period" {
  type        = number
  description = "Duração do período de avaliação para escala para baixo, em segundos."
  default     = 120
}

variable "scale_in_evaluation_periods" {
  type        = number
  description = "Número de períodos de avaliação necessários para acionar uma escala para baixo."
  default     = 3
}

variable "scale_in_cooldown" {
  type        = number
  description = "Período de cooldown após uma ação de escala para baixo, em segundos."
  default     = 120
}

### Tracking CPU

variable "scale_tracking_cpu" {
  type        = number
  description = "Valor de utilização de CPU alvo para o rastreamento de escala, em percentual."
  default     = 80
}

### Tracking Requests

variable "scale_tracking_requests" {
  type        = number
  description = "Número alvo de solicitações por segundo (TPS) para o rastreamento de escala."
  default     = 0
}