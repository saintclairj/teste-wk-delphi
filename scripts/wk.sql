/*
MySQL Data Transfer
Source Host: localhost
Source Database: wk
Target Host: localhost
Target Database: wk
Date: 10/12/2021 01:29:31
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `cidade` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `uf` varchar(2) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- ----------------------------
-- Table structure for pedido
-- ----------------------------
DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `data_emissao` date DEFAULT NULL,
  `valor_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cliente` (`cliente_id`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- ----------------------------
-- Table structure for pedido_item
-- ----------------------------
DROP TABLE IF EXISTS `pedido_item`;
CREATE TABLE `pedido_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `qtd` double DEFAULT NULL,
  `valor_unit` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedido` (`pedido_id`),
  KEY `fk_produto` (`produto_id`),
  CONSTRAINT `fk_produto` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`),
  CONSTRAINT `fk_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- ----------------------------
-- Table structure for produto
-- ----------------------------
DROP TABLE IF EXISTS `produto`;
CREATE TABLE `produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `preco_venda` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `descricao` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `cliente` VALUES ('1', 'fulano', 'Ituiutaba', 'MG');
INSERT INTO `cliente` VALUES ('2', 'ciclano', 'Uberlândia', 'MG');
INSERT INTO `cliente` VALUES ('3', 'beltrano', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('4', 'Fievemi', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('5', 'Fuar', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('6', 'Fliol', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('7', 'Neipios', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('8', 'Geisn', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('9', 'teste', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('10', 'cliente teste', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('11', 'Maria', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('12', 'Joaquim', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('13', 'João', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('14', 'Loyrane', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('15', 'Carlos', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('16', 'Tiago', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('17', 'Marcos', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('18', 'Felipe', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('19', 'Mariana', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('20', 'Hilda', 'Brasília', 'DF');
INSERT INTO `cliente` VALUES ('21', 'Thais', 'Brasília', 'DF');
INSERT INTO `pedido` VALUES ('2', '3', '2021-12-10', '8.50');
INSERT INTO `pedido` VALUES ('3', '5', '2021-12-10', '8.00');
INSERT INTO `pedido_item` VALUES ('4', '2', '3', '1', '7', '7');
INSERT INTO `pedido_item` VALUES ('5', '2', '5', '1', '1.5', '1.5');
INSERT INTO `pedido_item` VALUES ('6', '3', '4', '1', '7', '7');
INSERT INTO `pedido_item` VALUES ('7', '3', '8', '1', '1', '1');
INSERT INTO `produto` VALUES ('1', 'cartela de ovos', '6');
INSERT INTO `produto` VALUES ('2', 'coca cola 2L', '8');
INSERT INTO `produto` VALUES ('3', 'fanta laranja', '7');
INSERT INTO `produto` VALUES ('4', 'sprite', '7');
INSERT INTO `produto` VALUES ('5', 'agua mineral', '1.5');
INSERT INTO `produto` VALUES ('6', 'arroz', '25');
INSERT INTO `produto` VALUES ('7', 'macarrão', '4.5');
INSERT INTO `produto` VALUES ('8', 'miojo', '1');
INSERT INTO `produto` VALUES ('9', 'feijão', '4');
INSERT INTO `produto` VALUES ('10', 'ervilha', '3');
INSERT INTO `produto` VALUES ('11', 'sardinha', '4');
INSERT INTO `produto` VALUES ('12', 'atum', '4');
INSERT INTO `produto` VALUES ('13', 'mortadela', '5');
INSERT INTO `produto` VALUES ('14', 'desinfetante', '9');
INSERT INTO `produto` VALUES ('15', 'sabão em pó', '20');
INSERT INTO `produto` VALUES ('16', 'amaciante', '18');
INSERT INTO `produto` VALUES ('17', 'agua oxigenada', '7');
INSERT INTO `produto` VALUES ('18', 'água sanitaria', '12');
INSERT INTO `produto` VALUES ('19', 'azeite', '25');
INSERT INTO `produto` VALUES ('20', 'óleo de soja', '7');
INSERT INTO `produto` VALUES ('21', 'açucar', '15');
