CREATE TABLE IF NOT EXISTS reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    actividad VARCHAR(250) NOT NULL,
    nombre_cliente VARCHAR(100) NOT NULL,
    fecha_reserva DATE NOT NULL
);

INSERT INTO reservas (actividad, nombre_cliente, fecha_reserva) VALUES
('Taller de Cerámica Triana', 'María García', '2026-10-15'),
('Ruta Nocturna Alcázar', 'Juan Pérez', '2026-10-20');
