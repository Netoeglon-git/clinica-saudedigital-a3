CREATE DATABASE IF NOT EXISTS `saude_digital_a3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `saude_digital_a3`;

CREATE TABLE `unidade_saude` (
  `cnes` varchar(15) NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`cnes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `profissional_saude` (
  `registro_conselho` varchar(30) NOT NULL,
  `nome` varchar(120) NOT NULL,
  `funcao` varchar(60) NOT NULL,
  PRIMARY KEY (`registro_conselho`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `paciente` (
  `cns_paciente` char(15) NOT NULL,
  `nome_completo` varchar(120) NOT NULL DEFAULT 'Paciente Não Identificado',
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cns_paciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tipo_atendimento` (
  `id_tipo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(80) NOT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE KEY `descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `atendimento` (
  `id_atendimento` varchar(25) NOT NULL,
  `cns_paciente` char(15) NOT NULL,
  `cnes_unidade` varchar(15) NOT NULL,
  `registro_profissional` varchar(30) NOT NULL,
  `id_tipo_atendimento` int NOT NULL,
  `data_hora_atendimento` datetime NOT NULL,
  `motivo_consulta` text NOT NULL,
  `historico_doenca_atual` text NOT NULL,
  `diagnostico_cid10` varchar(10) NOT NULL,
  `conduta` text NOT NULL,
  `status_registro_blockchain` varchar(40) NOT NULL DEFAULT 'Pendente de Validação',
  `peso_kg` decimal(5,2) DEFAULT NULL,
  `altura_cm` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_atendimento`),
  KEY `idx_atendimento_data` (`data_hora_atendimento`),
  KEY `idx_atendimento_cid` (`diagnostico_cid10`),
  KEY `idx_atendimento_paciente` (`cns_paciente`),
  CONSTRAINT `fk_atend_paciente` FOREIGN KEY (`cns_paciente`) REFERENCES `paciente` (`cns_paciente`),
  CONSTRAINT `fk_atend_profissional` FOREIGN KEY (`registro_profissional`) REFERENCES `profissional_saude` (`registro_conselho`),
  CONSTRAINT `fk_atend_tipo` FOREIGN KEY (`id_tipo_atendimento`) REFERENCES `tipo_atendimento` (`id_tipo`),
  CONSTRAINT `fk_atend_unidade` FOREIGN KEY (`cnes_unidade`) REFERENCES `unidade_saude` (`cnes`),
  CONSTRAINT `chk_altura_positiva` CHECK ((`altura_cm` is null) or (`altura_cm` > 0)),
  CONSTRAINT `chk_peso_positivo` CHECK ((`peso_kg` is null) or (`peso_kg` > 0)),
  CONSTRAINT `chk_status_blockchain` CHECK (`status_registro_blockchain` in ('Pendente de Validação','Validado','Rejeitado'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `procedimento_realizado` (
  `id_procedimento` int NOT NULL AUTO_INCREMENT,
  `id_atendimento` varchar(25) NOT NULL,
  `nome_procedimento` varchar(120) NOT NULL,
  PRIMARY KEY (`id_procedimento`),
  CONSTRAINT `fk_proc_atendimento` FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `procedimento_detalhe` (
  `id_detalhe` int NOT NULL AUTO_INCREMENT,
  `id_procedimento` int NOT NULL,
  `chave_detalhe` varchar(50) NOT NULL,
  `valor_detalhe` varchar(150) NOT NULL,
  PRIMARY KEY (`id_detalhe`),
  CONSTRAINT `fk_det_procedimento` FOREIGN KEY (`id_procedimento`) REFERENCES `procedimento_realizado` (`id_procedimento`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
