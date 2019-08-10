SELECT servizio,
		 num_pro,
		 M,
		 F,
		 prov_si,
		 prov_no,
		 num_rqst,
		 num_qt, 
		 num_qt/num_rqst AS quote_per_request
FROM 
(SELECT rs.servizio AS servizio, 
		 COUNT(DISTINCT p.pro_id) AS num_pro, 
		 COUNT(DISTINCT(CASE WHEN p.Gender='M' then p.pro_id END)) AS M,
		 COUNT(DISTINCT(CASE WHEN p.Gender='F' then p.pro_id END)) AS F,
		 COUNT(DISTINCT(CASE WHEN p.in_provincia='Si' then p.pro_id END)) AS prov_si,
		 COUNT(DISTINCT(CASE WHEN p.in_provincia='No' then p.pro_id END)) AS prov_no,
		 COUNT(DISTINCT(pr.pronto_request_id)) AS num_rqst,
		 COUNT(DISTINCT(qp.quote_id)) AS num_qt
FROM pro AS p
LEFT JOIN pro_request AS pr
ON p.pro_id = pr.pro_id
LEFT JOIN request_servizio AS rs
ON rs.pronto_request_id = pr.pronto_request_id
LEFT JOIN quote_request AS qr
ON qr.pronto_request_id = rs.pronto_request_id
LEFT JOIN quote_pro AS qp
ON qr.quote_id = qp.quote_id
GROUP BY rs.servizio) AS T