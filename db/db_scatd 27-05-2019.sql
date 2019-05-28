-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-05-2019 a las 00:26:00
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_scatd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id_Cuenta` int(11) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `id_Usuario` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `ultimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id_Cuenta`, `Nombre`, `id_Usuario`, `estado`, `ultimaModificacion`) VALUES
(3, 'CUENTA PERSONAL', 1, 1, '2019-05-27 21:26:23'),
(4, 'MI PRESUPUESTO', 2, 1, '2019-05-27 21:33:05');

--
-- Disparadores `cuentas`
--
DELIMITER $$
CREATE TRIGGER `TR_SALDO_CUENTA` AFTER INSERT ON `cuentas` FOR EACH ROW BEGIN
	INSERT INTO mi_saldo (id_Cuenta,saldo) VALUES (NEW.id_Cuenta,0);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mi_saldo`
--

CREATE TABLE `mi_saldo` (
  `id` int(11) NOT NULL,
  `saldo` double NOT NULL,
  `id_Cuenta` int(11) NOT NULL,
  `ultimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mi_saldo`
--

INSERT INTO `mi_saldo` (`id`, `saldo`, `id_Cuenta`, `ultimaModificacion`) VALUES
(3, 0, 3, '2019-05-27 21:26:23'),
(4, 1100, 4, '2019-05-27 22:19:26');

--
-- Disparadores `mi_saldo`
--
DELIMITER $$
CREATE TRIGGER `TR_MOVIMIENTOS_SALDO` AFTER UPDATE ON `mi_saldo` FOR EACH ROW BEGIN
	IF (NEW.saldo > OLD.saldo) THEN
    	INSERT INTO movimientoscuentas (id_Cuenta,tipo_movimiento,Saldo_Anterior,Saldo_Nuevo,monto) VALUES (NEW.id_Cuenta,'Deposito',OLD.saldo,NEW.saldo,(NEW.saldo-OLD.saldo));
    END IF;
    IF (NEW.saldo < OLD.saldo) THEN
    	INSERT INTO movimientoscuentas (id_Cuenta,tipo_movimiento,Saldo_Anterior,Saldo_Nuevo,monto) VALUES (NEW.id_Cuenta,'Retiro',OLD.saldo,NEW.saldo,(NEW.saldo-OLD.saldo));
    END IF;
 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientoscuentas`
--

CREATE TABLE `movimientoscuentas` (
  `id` int(11) NOT NULL,
  `tipo_movimiento` varchar(50) NOT NULL,
  `id_Cuenta` int(11) NOT NULL,
  `monto` double NOT NULL,
  `Saldo_Anterior` double NOT NULL,
  `Saldo_Nuevo` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `movimientoscuentas`
--

INSERT INTO `movimientoscuentas` (`id`, `tipo_movimiento`, `id_Cuenta`, `monto`, `Saldo_Anterior`, `Saldo_Nuevo`) VALUES
(1, 'Transaccion', 4, 0, 0, 3000),
(2, 'Retiro', 4, 0, 3000, 2450),
(3, 'Deposito', 4, 200, 2450, 2650),
(4, 'Retiro', 4, -350, 2650, 2300),
(5, 'Retiro', 4, -500, 2300, 1800),
(6, 'Retiro', 4, -300, 1800, 1500),
(7, 'Retiro', 4, -250, 1500, 1250),
(8, 'Retiro', 4, -150, 1250, 1100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `sexo` varchar(10) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(20) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `direccionCiudad` varchar(250) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `foto` text NOT NULL,
  `ultimaModificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `sexo`, `telefono`, `email`, `password`, `ciudad`, `direccionCiudad`, `estado`, `pais`, `foto`, `ultimaModificacion`) VALUES
(1, 'ALDO ALEJANDRO', 'SANCHEZ FELIX', 'MASCULINO', '6971077843', 'alejandroaldo97@gmail.com', 'admin123', 'LA REFORMA.', 'CALLE RIO HUMAYA S/N.', 'SINALOA.', 'MEXICO.', 'SIN FOTO', '2019-05-27 21:27:42'),
(2, 'JULISSHA', 'ROSAS MONTOYA', 'FEMENINO', 'NULL', 'NULL', 'admin123', 'LA REFORMA.', 'NULL', 'SINALOA.', 'MEXICO.', 'SIN FOTO', '2019-05-27 21:32:06');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id_Cuenta`),
  ADD KEY `FK_CUENTA_USUARIO` (`id_Usuario`) USING BTREE;

--
-- Indices de la tabla `mi_saldo`
--
ALTER TABLE `mi_saldo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_Usuario` (`id_Cuenta`);

--
-- Indices de la tabla `movimientoscuentas`
--
ALTER TABLE `movimientoscuentas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_MOVIMIENTOS_SALDO` (`id_Cuenta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id_Cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `mi_saldo`
--
ALTER TABLE `mi_saldo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `movimientoscuentas`
--
ALTER TABLE `movimientoscuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD CONSTRAINT `FK_CUENTA_USUARIO` FOREIGN KEY (`id_Usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mi_saldo`
--
ALTER TABLE `mi_saldo`
  ADD CONSTRAINT `FK_SALDO_CUENTA` FOREIGN KEY (`id_Cuenta`) REFERENCES `cuentas` (`id_Cuenta`) ON DELETE CASCADE;

--
-- Filtros para la tabla `movimientoscuentas`
--
ALTER TABLE `movimientoscuentas`
  ADD CONSTRAINT `FK_MOVIMIENTOS_SALDO` FOREIGN KEY (`id_Cuenta`) REFERENCES `cuentas` (`id_Cuenta`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
