<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.lang.System"%>

<!DOCTYPE html>
<html>
<%
	String url = request.getRequestURL().toString();
	String baseURL = url.substring(0, url.length() - request.getRequestURI().length())
			+ request.getContextPath() + "/";
	SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
	SimpleDateFormat incoming = new SimpleDateFormat("dd-MM-yyyy");
	String incomingDate = request.getParameter("var") != null ? request.getParameter("var")
			: sdf.format(new Date());
	String today_date = sdf.format(new Date());
	int size = 0;
%>
<head>
<link rel="shortcut icon" href="<%=baseURL%>favicon.ico" type="image/x-icon" />
<link rel="icon" href="<%=baseURL%>favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="<%=baseURL%>assets/css/dashboard.css">
<link rel="stylesheet" href="<%=baseURL%>assets/css/all.css">
<link rel="stylesheet" href="<%=baseURL%>assets/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=baseURL%>assets/css/salesken_style.css">
<link href="<%=baseURL%>assets/css/bootstrap-datepicker3.min.css?xsww" rel="stylesheet">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link rel="stylesheet" href="<%=baseURL%>assets/css/wickedpicker.min.css">
<link rel="stylesheet" href="<%=baseURL%>assets/css/salesken_style_media_query.css">

<link rel="stylesheet" href="<%=baseURL%>assets/css/salesken_style.css">


<meta charset="ISO-8859-1">
<title>Dashboard</title>
</head>
<body data-baseurl="<%=baseURL%>">
	<!-- Start of dashboard header div with dashboard title and New task -->
	<div class="container-fluid salesken_container">
		<div class="row pb-3" id="incoming_date" data-input_date="<%=incomingDate%>">
			<div class="col-md-6 col-6 p-0 m-0 d-flex align-items-center">
				<h1 class="display-1 black f-20 fw-500 mb-0">Dashboard</h1>
			</div>
			<div class="col-md-6 col-6 d-flex justify-content-end ">
				<div class="dropdown">
					<button class="btn small_button rounded-0 f-12 dropdown-toggle font-weight-bold " data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew" id="dashboard_activity" data-toggle="dropdown" data-display="static" aria-haspopup="true" aria-expanded="false">
						<span class="sr-only">Toggle Dropdown</span>NEW TASK <img src="<%=baseURL%>/assets/image/toggle_white.svg" alt="call" class="h-17 text-white ">
					</button>
					<div class="dropdown-menu dropdown-menu-right istar-dropdown-task-menu" aria-labelledby="dashboard_activity">
						<button class="dropdown-item" type="button" onclick="NavigateTo('newCallTask')">
							<img src="<%=baseURL%>assets/image/calltask.svg" alt="call" class="task-dropdown"> Call Task
						</button>
						<button class="dropdown-item" type="button">
							<img src="<%=baseURL%>assets/image/emailtask.svg" alt="email" class="task-dropdown"> Email Task
						</button>
						<button class="dropdown-item" type="button">
							<img src="<%=baseURL%>assets/image/webinartask.svg" alt="webinar" class="task-dropdown"> Webinar Task
						</button>
						<button class="dropdown-item" type="button">
							<img src="<%=baseURL%>assets/image/presentation.svg" alt="presentation" class="task-dropdown"> Presentation
						</button>
					</div>
				</div>
			</div>
		</div>
		<!-- End of dashboard header div with dashboard title and New task -->
		<!-- Start of row in main dashboard. This row divided into three major UI column -->
		<div class="row ">
			<!-- Start of left container/first column of dashboard  -->
			<div class="col-md-3 pr-0 left_container pl-0 bg-white"></div>

			<!-- End of left container/first column of dashboard  -->
			<!-- start of center container/second column of dashboard  -->
			<div class="col-md-6 p-0 m-0 center_container ">
				<!-- Start of Pipeline and Stages card-->
				<div class="align-items-center pt-10 pb-10 shadow pl-30 mb-10 light_blue-bg pr-30" style="display: none">
					<i class="fal fa-info-circle soft-blue f-18 pr-5"></i> <em class="soft-blue font-weight-bold f-12">Information <span class="fw-300 ">: The date cannot be in the future !</span>
					</em>
				</div>
				<div class="pipeline-card">
					<div class="card shadow mb-2 rounded-0" style="min-height: 322px;">
						<div class="card-body p-0">
							<div class="salesken_caurosel pipeline-card-parent position-relative overflow-hidden">

								<button type="button" class="istar-btn-icon  previous p-0" id="pipeline-left" onclick="pipeline_prev(this)">
									<i class="fal fa-chevron-left"></i>
								</button>
								<button type="button" class="istar-btn-icon  active next p-0" id="pipeline-right" onclick="pipeline_next(this)">
									<i class="fal fa-chevron-right"></i>
								</button>
								<div id="pipeline-card"></div>
							</div>
						</div>
					</div>



				</div>
				<!-- End of Pipeline and Stages card-->
				<!-- Start of Signal and its count card -->
				<div id="carouselExampleIndicators" class="carousel slide mb-2" data-ride="carousel"></div>
				<!-- End of Signal and its count card -->
				<!-- Start of Teams card-->
				<div class="team-card pb-10">
					<div class="card shadow p-0 rounded-0">
						<div class="card-body p-0 position-relative overflow-hidden">
							<button type="button" class="istar-btn-icon previous p-0 cursor-hand" onclick="team_prev(this)" style="position: absolute; z-index: 5;" id="team-left">
								<i class="fal fa-chevron-left"></i>
							</button>
							<button type="button" class="istar-btn-icon  active next p-0 cursor-hand" onclick="team_next(this)" style="position: absolute; z-index: 5;" id="team-right">
								<i class="fal fa-chevron-right"></i>
							</button>
							<div class="salesken_caurosel position-relative " data-index="0" data-child="team-container"></div>
							<div id="team-card"></div>
						</div>
					</div>
				</div>
				<!-- End of Teams card-->
				<!-- Start of Top/Bottom 5 Agent card-->
				<div class="top-bottom-agent-card"></div>
				<!-- End of Top/Bottom 5 Agent card-->
			</div>
			<!-- End of center container/second column of dashboard  -->
			<!-- Start of right container/third column of dashboard  -->
			<div class="col-md-3 p-0 pl-md-3 pr-md-3">
				<div></div>
				<!-- Start of ongoing task list 
                     initially it will be hidden   
                     We will display this container on click of view more click
                     -->
				<div class="ongoing_task_container position-relative" style="display: none;">
					<div class="row">
						<div class="col">
							<div class="d-flex mb-3 border-top-task_list ">
								<div class="mr-auto pt-4 greyish-brown f-16 font-weight-bold">Task List</div>
								<button type="button" class="close task very-light-pink-bg pt-4 removefocus" aria-label="Close" style="">
									<img src="<%=baseURL%>assets/image/close.svg" alt="taskicon" class="border-0 hw-24 task-icon">
								</button>
							</div>
						</div>
					</div>
					<div class="ongoing_task_content"></div>
				</div>
				<!-- End of ongoing task list (view more click on ongoing task card) -->
				<!-- Start of resolve task list 
                     initially it will be hidden   
                     We will display this container on click of view more click
                     -->
				<div class="task_resolve_container position-relative" style="display: none;">
					<div class="row">
						<div class="col">
							<div class="d-flex mb-3 border-top-task_list ">
								<div class="mr-auto pt-4 greyish-brown f-16 font-weight-bold">RESOLVE</div>
								<button type="button" class="close resolve_task very-light-pink-bg pt-4 removefocus" aria-label="Close" style="">
									<img src="<%=baseURL%>assets/image/close.svg" alt="taskicon" class="border-0 hw-24 task-icon">
								</button>
							</div>
						</div>
					</div>
					<div class="task_resolve_content"></div>
				</div>
				<!-- End of ongoing task list (view more click on ongoing task card) -->
				<button type="button" onclick="onCloseClick()" class="btn p-0 mb-2 showmore_close" style="display: none">
					<img src="<%=baseURL%>assets/image/close.svg" alt="taskicon" class="border-0 hw-24 task-icon">
				</button>

				<div class="third_main_container_behind"></div>


				<div class="third_main_container">

					<!-- Start of Associate Join now/Listen card-->
					<div class="" id="ongoing_task_card"></div>
					<!-- End of Associate Join now/Listen card-->
					<!-- Start of issue resolve card-->
					<div class="" id="raise_issue_card"></div>
					<!-- End of issue resolve card-->
					<!-- Start of chat now card-->
					<div class="" id="chat_card" onclick='NavigateTo("taskLeadDetail")'></div>
					<!-- End of chat now card-->
					<!-- Start of accepting incoming call by Associate card-->
					<div class="" id="upcoming_meeting"></div>
					<!-- End of accepting incoming call by Associate card-->
				</div>
			</div>
			<!-- End of right container/third column of dashboard  -->
		</div>
	</div>
	<!-- End of row main dashboard row divided into three column -->


	<script src="<%=baseURL%>assets/js/jquery-3.4.1.min.js"></script>
	<script src="<%=baseURL%>assets/js/popper.min.js"></script>

	<script src="<%=baseURL%>assets/js/bootstrap.min.js"></script>
	<script src="<%=baseURL%>assets/js/bootstrap-datepicker.min.js"></script>
	<script src="<%=baseURL%>assets/js/dashboard.js"></script>
	<script src="<%=baseURL%>assets/js/dashboard_center.js"></script>
	<script src="<%=baseURL%>assets/js/dashboard_right.js"></script>

	<script src="<%=baseURL%>assets/js/underscore-min.js"></script>
	<script src="<%=baseURL%>assets/js/summernote-bs4.js"></script>

	<script src="<%=baseURL%>assets/js/backbone.js"></script>

</body>
</html>
