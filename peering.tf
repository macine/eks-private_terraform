resource "aws_vpc_peering_connection" "peer1" {
  peer_vpc_id   = module.vpc.vpc_id
  vpc_id        = data.aws_vpc.vpc_actual.id
  auto_accept   = true
}

resource "aws_route" "route1" {
  route_table_id            = module.vpc.default_route_table_id
  destination_cidr_block    = data.aws_vpc.vpc_actual.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer1.id
}

resource "aws_route" "route3" {
  route_table_id            = module.vpc.private_route_table_ids[0]
  destination_cidr_block    = data.aws_vpc.vpc_actual.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer1.id
}


resource "aws_route" "route2" {
  route_table_id            = data.aws_vpc.vpc_actual.main_route_table_id 
  destination_cidr_block    = module.vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer1.id

}
