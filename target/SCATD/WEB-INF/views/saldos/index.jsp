<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<tags:template>
	<jsp:attribute name="head">
		<title>Saldos</title> 
		<script type="text/javascript">
			// inline JavaScript here 
		</script>
  	</jsp:attribute>  
	<jsp:body>
		<div class="container bg-light">
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4 center"><h1>Saldos</h1></div>
				<div class="col-md-4"></div>
			</div>
			<div class="row">
				<table class="table table-bordered" id="tablaUsuarios">
				<thead  class="thead-dark">
    				<tr class="text-center">
						<th>Nombre</th>
						<th>Apellido</th>
						<th>Saldo</th>
					</tr>
				</thead>
  				<tbody class="text-center" id="datosTabla">
					<c:forEach var="infoSaldo" items="${infoSaldo}">
						<tr class="text-center">
							<td class="text-center">${infoSaldo.nombre}</td>
							<td class="text-center">${infoSaldo.apellido}</td>
							<td class="text-center">${infoSaldo.saldo}</td>
						</tr>
				</c:forEach>
 				</tbody>
			</table>
				
			</div>
		</div>
	</jsp:body>
</tags:template>