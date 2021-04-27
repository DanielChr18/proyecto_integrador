<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!--     Fonts and icons     -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<!-- CSS Files -->
<link href="css/material-dashboard.css?v=2.1.2" rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="demo/demo.css" rel="stylesheet" />


<div class="sidebar" data-color="purple" data-background-color="white"
	data-image="img/sidebar-1.jpg">
	<!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

        Tip 2: you can also add an image using data-image tag
    -->
	<div class="logo">
		<a href="#" class="simple-text logo-normal"
			style="font-family: Algerian; font-size: 30px; color: #8e24aa;">
			ZOOTOPIA </a>
	</div>
	<div class="sidebar-wrapper">
		<ul class="nav">
			<li class="nav-item" id="id_menuNosotros"><a class="nav-link"
				href="crudProducto"><i class="material-icons">person</i>
					<p>Nosotros</p></a></li>
			<c:if test="${objCargo != 'Personal de Ventas'}">
				<li class="nav-item" id="id_menuServicios"><a class="nav-link"
					href="listaServicios"><i class="material-icons">medical_services</i>
						<p>Servicios</p></a></li>
				<li class="nav-item" id="id_menuProductos"><a class="nav-link"
					href="listaProductos"><i class="material-icons">inventory_2</i>
						<p>Productos</p></a></li>
			</c:if>
			<c:if test="${objCargo == 'Personal de Ventas'}">
				<li class="nav-item" id="id_menuCrudServicios"><a
					class="nav-link" href="crudServicios"><i class="material-icons">medical_services</i>
						<p>Servicios</p></a></li>
				<li class="nav-item" id="id_menuCrudProductos"><a
					class="nav-link" href="crudProductos"><i class="material-icons">inventory_2</i>
						<p>Productos</p></a></li>
				<li class="nav-item" id="id_menuCrudMarcas"><a class="nav-link"
					href="crudMarcas"><i class="material-icons">content_paste</i>
						<p>Marcas</p></a></li>
				<li class="nav-item" id="id_menuCrudProveedores"><a
					class="nav-link" href="crudProveedores"><i class="material-icons">next_week</i>
						<p>Proveedores</p></a></li>
			</c:if>
			<c:if test="${objCargo == 'Cliente'}">
				<li class="nav-item" id="id_menuClientes"><a class="nav-link"
					href="datosMascotas"><i class="material-icons">pets</i>
						<p>Mascotas</p></a></li>
			</c:if>
			<c:if test="${objCargo == null}">
				<li class="nav-item" id="id_menuClientes"><a class="nav-link"
					href="datosClientes"><i class="material-icons">person</i>
						<p>Contactanos</p></a></li>
			</c:if>
		</ul>
	</div>
</div>


<!--   Core JS Files   -->
<script src="js/core/popper.min.js"></script>
<script src="js/core/bootstrap-material-design.min.js"></script>
<script src="js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!-- Plugin for the momentJs  -->
<script src="js/plugins/moment.min.js"></script>
<!--  Plugin for Sweet Alert -->
<script src="js/plugins/sweetalert2.js"></script>
<!-- Forms Validations Plugin -->
<script src="js/plugins/jquery.validate.min.js"></script>
<!-- Plugin for the Wizard, full documentation here: https://github.com/VinceG/twitter-bootstrap-wizard -->
<script src="js/plugins/jquery.bootstrap-wizard.js"></script>
<!--	Plugin for Select, full documentation here: http://silviomoreto.github.io/bootstrap-select -->
<script src="js/plugins/bootstrap-selectpicker.js"></script>
<!--  Plugin for the DateTimePicker, full documentation here: https://eonasdan.github.io/bootstrap-datetimepicker/ -->
<script src="js/plugins/bootstrap-datetimepicker.min.js"></script>
<!--  DataTables.net Plugin, full documentation here: https://datatables.net/  -->
<script src="js/plugins/jquery.dataTables.min.js"></script>
<!--	Plugin for Tags, full documentation here: https://github.com/bootstrap-tagsinput/bootstrap-tagsinputs  -->
<script src="js/plugins/bootstrap-tagsinput.js"></script>
<!-- Plugin for Fileupload, full documentation here: http://www.jasny.net/bootstrap/javascript/#fileinput -->
<script src="js/plugins/jasny-bootstrap.min.js"></script>
<!--  Full Calendar Plugin, full documentation here: https://github.com/fullcalendar/fullcalendar    -->
<script src="js/plugins/fullcalendar.min.js"></script>
<!-- Vector Map plugin, full documentation here: http://jvectormap.com/documentation/ -->
<script src="js/plugins/jquery-jvectormap.js"></script>
<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="js/plugins/nouislider.min.js"></script>
<!-- Include a polyfill for ES6 Promises (optional) for IE11, UC Browser and Android browser support SweetAlert -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
<!-- Library for adding dinamically elements -->
<script src="js/plugins/arrive.min.js"></script>
<!--  Google Maps Plugin    -->
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!-- Chartist JS -->
<script src="js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="js/material-dashboard.js?v=2.1.2" type="text/javascript"></script>
<!-- Material Dashboard DEMO methods, don't include it in your project! -->
<script src="demo/demo.js"></script>