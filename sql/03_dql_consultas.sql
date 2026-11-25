USE `saude_digital_a3`;

SELECT a.id_atendimento, a.data_hora_atendimento, p.nome_completo AS paciente,
       t.descricao AS tipo, prof.nome AS profissional, a.diagnostico_cid10
FROM atendimento a
INNER JOIN paciente p ON a.cns_paciente = p.cns_paciente
INNER JOIN tipo_atendimento t ON a.id_tipo_atendimento = t.id_tipo
INNER JOIN profissional_saude prof ON a.registro_profissional = prof.registro_conselho
ORDER BY a.data_hora_atendimento DESC;

SELECT prof.nome AS profissional, prof.funcao, COUNT(a.id_atendimento) AS total_atendimentos,
       ROUND(AVG(a.peso_kg), 2) AS media_peso_pacientes
FROM profissional_saude prof
LEFT JOIN atendimento a ON prof.registro_conselho = a.registro_profissional
GROUP BY prof.registro_conselho, prof.nome, prof.funcao;

SELECT a.id_atendimento, p.nome_completo, pr.nome_procedimento, pd.chave_detalhe, pd.valor_detalhe
FROM atendimento a
INNER JOIN paciente p ON a.cns_paciente = p.cns_paciente
LEFT JOIN procedimento_realizado pr ON a.id_atendimento = pr.id_atendimento
LEFT JOIN procedimento_detalhe pd ON pr.id_procedimento = pd.id_procedimento
WHERE a.data_hora_atendimento BETWEEN '2026-10-18 00:00:00' AND '2026-10-18 23:59:59';
