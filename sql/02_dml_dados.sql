USE `saude_digital_a3`;

INSERT INTO `unidade_saude` VALUES ('1000001','UBS Central');

INSERT INTO `profissional_saude` VALUES
('COREN-SP 123456','Ana Paula Souza','Enfermeira'),
('COREN-SP 555555','Maria Helena Silva','Técnica em Enfermagem'),
('CRM-SP 100200','Dr. Carlos Mendes','Médico'),
('CRM-SP 200300','Dra. Fernanda Lima','Médica'),
('CRM-SP 300400','Dr. Roberto Alves','Médico'),
('CRO-SP 7788','Dr. Paulo Ribeiro','Cirurgião-dentista'),
('CRP-06 4455','Dra. Beatriz Nunes','Psicóloga');

INSERT INTO `paciente` VALUES
('900000000010001','Paciente RN 01',1),('900000000010002','Paciente Gestante 02',1),
('900000000010003','Paciente Pediátrico 03',1),('900000000010004','Paciente Hipertenso 04',1),
('900000000010005','Paciente Diabético 05',1),('900000000010006','Paciente Odonto 06',1),
('900000000010007','Paciente Saúde Mental 07',1),('900000000010008','Paciente Geriátrico 08',1),
('900000000010009','Paciente Lactente 09',1),('900000000010010','Paciente Curativo 10',0);

INSERT INTO `tipo_atendimento` VALUES
(1,'Vacinação'),(2,'Consulta Pré-natal'),(3,'Consulta Pediátrica'),(4,'Consulta Hipertensão'),
(5,'Consulta Diabetes'),(6,'Consulta Odontológica'),(7,'Consulta Saúde Mental'),
(8,'Consulta Geriátrica'),(9,'Consulta Puericultura'),(10,'Outro');

INSERT INTO `atendimento` VALUES
('ATND-20261018-001','900000000010001','1000001','COREN-SP 555555',1,'2026-10-18 09:30:00','Primeira vacinação de recém-nascido.','Sem intercorrências no momento da aplicação.','Z23.5','Aplicação de vacinas BCG e Hepatite B.','Validado',3.40,50.00),
('ATND-20261018-002','900000000010002','1000001','COREN-SP 123456',2,'2026-10-18 10:10:00','Acompanhamento pré-natal de rotina.','Gestação de 20 semanas, sem queixas.','Z34.8','Solicitados exames de rotina; retorno em 30 dias.','Pendente de Validação',68.50,162.00),
('ATND-20261018-003','900000000010003','1000001','CRM-SP 100200',3,'2026-10-18 11:00:00','Febre há dois dias.','Febre baixa, sem outros sintomas.','R50.9','Hidratação e antitérmico; retorno se piorar.','Pendente de Validação',14.20,95.00),
('ATND-20261018-004','900000000010004','1000001','CRM-SP 200300',4,'2026-10-18 13:20:00','Controle de pressão arterial.','Hipertensão em uso regular de medicação.','I10','Mantida a medicação; reavaliação em 60 dias.','Pendente de Validação',82.00,170.00),
('ATND-20261018-005','900000000010005','1000001','CRM-SP 200300',5,'2026-10-18 14:00:00','Acompanhamento de diabetes tipo 2.','Sem queixas; adesão parcial à dieta.','E11.9','Orientação alimentar e solicitação de hemoglobina glicada.','Pendente de Validação',90.30,168.00),
('ATND-20261018-006','900000000010006','1000001','CRO-SP 7788',6,'2026-10-18 15:15:00','Dor em dente molar.','Dor há uma semana ao mastigar.','K02.1','Restauração agendada.','Pendente de Validação',NULL,NULL),
('ATND-20261018-007','900000000010007','1000001','CRP-06 4455',7,'2026-10-18 16:00:00','Acompanhamento psicológico.','Relata ansiedade leve.','F41.9','Retorno semanal.','Pendente de Validação',NULL,NULL),
('ATND-20261018-008','900000000010008','1000001','CRM-SP 300400',8,'2026-10-18 08:40:00','Avaliação geriátrica de rotina.','Sem queixas; boa autonomia.','Z00.0','Manter atividades físicas leves.','Pendente de Validação',71.00,165.00),
('ATND-20261018-009','900000000010009','1000001','COREN-SP 123456',9,'2026-10-18 09:00:00','Acompanhamento do crescimento.','Lactente em aleitamento materno.','Z00.1','Orientações de aleitamento e vacinação.','Pendente de Validação',6.80,63.00),
('ATND-20261018-010','900000000010010','1000001','COREN-SP 555555',10,'2026-10-18 17:00:00','Curativo simples.','Pequeno corte no antebraço.','T14.1','Limpeza e curativo; orientação de cuidados.','Pendente de Validação',NULL,NULL);

INSERT INTO `procedimento_realizado` VALUES
(1,'ATND-20261018-001','Aplicação de Vacina BCG'),(2,'ATND-20261018-001','Aplicação de Vacina Hepatite B'),
(3,'ATND-20261018-002','Medida de altura uterina'),(4,'ATND-20261018-002','Ausculta de batimentos cardiofetais'),
(5,'ATND-20261018-003','Aferição de temperatura'),(6,'ATND-20261018-004','Aferição de pressão arterial'),
(7,'ATND-20261018-005','Glicemia capilar'),(8,'ATND-20261018-006','Avaliação odontológica'),
(9,'ATND-20261018-007','Escuta qualificada'),(10,'ATND-20261018-008','Avaliação funcional'),
(11,'ATND-20261018-009','Aferição de perímetro cefálico'),(12,'ATND-20261018-010','Curativo simples');

INSERT INTO `procedimento_detalhe` VALUES
(1,1,'lote','LOTEBCG2024'),(2,1,'via','Intradérmica'),(3,2,'lote','LOTEHB2024'),(4,2,'via','Intramuscular'),
(5,3,'valorCm','19'),(6,4,'bpm','142'),(7,5,'valorC','37.8'),(8,6,'sistolica','138'),
(9,6,'diastolica','88'),(10,7,'valorMgDl','146'),(11,7,'jejum','sim'),(12,8,'dente','36'),
(13,9,'duracaoMin','50'),(14,10,'escala','Katz'),(15,10,'pontos','6'),(16,11,'valorCm','41'),
(17,12,'material','gaze e soro fisiológico');
