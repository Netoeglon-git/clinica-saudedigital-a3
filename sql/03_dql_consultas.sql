-- ==============================================================================
-- PROJETO INTEGRADOR (AVALIAÇÃO A3) — CLÍNICA SAÚDEDIGITAL
-- ARQUIVO: 03_dql_consultas.sql
-- DESCRIÇÃO: Consultas analíticas e gerenciais (DQL) utilizando INNER JOIN,
--            LEFT JOIN, GROUP BY, funções de agregação (COUNT, AVG) e filtros.
-- SGBD: MySQL / MariaDB
-- ==============================================================================

USE saude_digital_a3;

-- 1. RELATÓRIO COMPLETO DE PRONTUÁRIOS (INNER JOIN entre 5 tabelas)
SELECT 
    a.id_atendimento AS 'Protocolo',
    DATE_FORMAT(a.data_hora_atendimento, '%d/%m/%Y %H:%i') AS 'Data_Hora',
    p.nome_completo AS 'Paciente',
    p.cns_paciente AS 'CNS',
    u.nome AS 'Unidade',
    prof.nome AS 'Profissional',
    prof.funcao AS 'Especialidade',
    t.descricao AS 'Tipo_Atendimento',
    a.diagnostico_cid10 AS 'CID10',
    a.status_registro_blockchain AS 'Status_Auditoria'
FROM atendimento a
INNER JOIN paciente p ON a.cns_paciente = p.cns_paciente
INNER JOIN unidade_saude u ON a.cnes_unidade = u.cnes
INNER JOIN profissional_saude prof ON a.registro_profissional = prof.registro_conselho
INNER JOIN tipo_atendimento t ON a.id_tipo_atendimento = t.id_tipo
ORDER BY a.data_hora_atendimento DESC;

-- 2. PROCEDIMENTOS E DETALHES POR ATENDIMENTO (LEFT JOIN para incluir atendimentos sem procedimentos)
SELECT 
    a.id_atendimento AS 'Protocolo',
    p.nome_completo AS 'Paciente',
    COALESCE(pr.nome_procedimento, 'Nenhum procedimento realizado') AS 'Procedimento',
    COALESCE(pd.chave_detalhe, '-') AS 'Parametro',
    COALESCE(pd.valor_detalhe, '-') AS 'Valor_Medido'
FROM atendimento a
INNER JOIN paciente p ON a.cns_paciente = p.cns_paciente
LEFT JOIN procedimento_realizado pr ON a.id_atendimento = pr.id_atendimento
LEFT JOIN procedimento_detalhe pd ON pr.id_procedimento = pd.id_procedimento
ORDER BY a.id_atendimento;

-- 3. INDICADOR GERENCIAL: TOTAL DE ATENDIMENTOS E MÉDIA DE PESO POR PROFISSIONAL (GROUP BY, COUNT, AVG)
SELECT 
    prof.nome AS 'Profissional',
    prof.funcao AS 'Especialidade',
    COUNT(a.id_atendimento) AS 'Total_Atendimentos',
    ROUND(AVG(a.peso_kg), 2) AS 'Media_Peso_Pacientes_Kg'
FROM profissional_saude prof
LEFT JOIN atendimento a ON prof.registro_conselho = a.registro_profissional
GROUP BY prof.registro_conselho, prof.nome, prof.funcao
ORDER BY Total_Atendimentos DESC;

-- 4. FILTRO POR PERÍODO DE DATA E STATUS DE AUDITORIA
SELECT 
    id_atendimento,
    data_hora_atendimento,
    cns_paciente,
    diagnostico_cid10,
    status_registro_blockchain
FROM atendimento
WHERE data_hora_atendimento BETWEEN '2026-11-01 00:00:00' AND '2026-11-30 23:59:59'
  AND status_registro_blockchain = 'Validado'
ORDER BY data_hora_atendimento ASC;
