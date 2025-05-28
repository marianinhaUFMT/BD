# Trabalho de Banco de Dados - Sistema de Gestão de Clínicas Médicas
Uma rede de clínicas médicas, chamada Saúde+, deseja informa􀆟zar seu processo de
agendamento de consultas e controle de pacientes. Atualmente, os registros são feitos
manualmente, causando problemas como sobreposição de horários, dificuldade de acesso ao
histórico de pacientes e falta de organização no controle de pagamentos.
Para solucionar esses problemas, sua equipe foi contratada para desenvolver um banco de
dados capaz de gerenciar médicos, pacientes, consultas, procedimentos médicos e
pagamentos.
Requisitos do Sistema:
1. Pacientes são cadastrados com CPF, nome, data de nascimento, telefone, endereço e
convênio (se houver).
2. Médicos possuem um CRM único, nome, especialidade e telefone.
3. Consultas possuem data, hora, status (agendada, concluída, cancelada) e são sempre
associadas a um médico e um paciente.
4. Um médico pode atender vários pacientes, mas um paciente só pode ser atendido por
um médico por consulta.
5. Procedimentos médicos podem ser realizados durante uma consulta (exemplo: raio-X,
exames laboratoriais, sutura). Cada procedimento tem um código, nome, valor e
tempo es􀆟mado de realização.
6. Uma consulta pode ter vários procedimentos, e um mesmo procedimento pode ser
realizado em várias consultas.
7. Pagamentos podem ser feitos pelo paciente ou pelo convênio e são associados a uma
consulta. Devem registrar o valor, a forma de pagamento (cartão, dinheiro, boleto) e o
status (pago, pendente, cancelado).
8. Um paciente pode realizar vários pagamentos (se fizer várias consultas), e uma
consulta pode envolver mais de um pagamento (exemplo: parte paga pelo paciente e
parte pelo convênio).
9. Convênios médicos têm um código, nome e porcentagem de cobertura sobre
procedimentos e consultas. Um paciente pode estar associado a apenas um convênio,
mas um convênio pode cobrir vários pacientes.
10. Recepcionistas são responsáveis pelo agendamento das consultas e precisam ser
registradas no sistema com nome, CPF e telefone.

Segunda parte do trabalho
1. Faça inserções em todas as tabelas por você criadas (ao menos 10).
2. Realize as seguintes consultas:
- Listar todas as consultas agendadas para um determinado médico em um dia
específico;
- Contar quantas consultas cada médico realizou no último mês
- Encontrar os pacientes que nunca tiveram uma consulta agendada
- Listar os procedimentos realizados em uma consulta específica
- Calcular o total pago por cada paciente nos últimos 3 meses
- Identificar os convênios que cobrem mais de 50% do valor das consultas
- Listar todos os pacientes atendidos por um determinado médico
- Mostrar o faturamento total do último mês, considerando apenas pagamentos
concluídos
- Encontrar os médicos que possuem mais de 5 consultas marcadas para a
próxima semana
- Listar os pacientes que mais gastaram na clínica nos úl􀆟mos 6 meses
