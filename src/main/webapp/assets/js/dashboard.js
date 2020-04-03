$(document).ready(function(){
	var DashboardLeft = Backbone.Model.extend();
	console.log('ready')
	var contextPath = $('body').data('baseurl')
	window.App = {

		    get : function(url) {
		        var data = "<h1> failed to load url : " + url + "</h1>";
		        console.log(url)
		        $.ajax({
		            async: false,
		            url: url,
		            dataType: "text",

		            success: function(response) {
		                data = response;
		            }
		        });
		        return data;
		    }
		}

	var DashboardLeftView = Backbone.View.extend({
		render: function (){
			
			var template = _.template(App.get(contextPath+'templates/dashboard/dashboard_left.html'));
			var html = template(this.model.toJSON());
			this.$el.html(html);
			var active_dates = ["2/4/2020", "5/4/2020"];
			

			$('#datepicker').datepicker({
				todayHighlight: true,
				updateViewDate: true,
				weekStart: 1,
				beforeShowDay: function(date) {
					var newHeight = $("#datepicker").width();
					$(".table-condensed").height(newHeight);// setting height equal to width of the calendar.
					$("#datepicker").width($(".table-condensed").height())		
					var d = date;
					var curr_date = d.getDate();
					var curr_month = d.getMonth() + 1; //Months are zero based
					var curr_year = d.getFullYear();
					var formattedDate = curr_date + "/" + curr_month + "/" + curr_year
					if ($.inArray(formattedDate, active_dates) != -1) {
						return {
							classes: 'activeClass'
						};
					}
					return;
				}
			});

			$("#datepicker").datepicker("update", $('#incoming_date').data('input_date'));
			
			
			$('#datepicker').on('changeDate', function() {
				console.log($('#datepicker').datepicker('getFormattedDate'));
				NavigationService({name:'var',value:$('#datepicker').datepicker('getFormattedDate')})
			
			});
			return this;
		}
	})

	var dashboardLeft = new DashboardLeft({title:'sssssss',baseURL:contextPath})


	var dashboardLeftView = new DashboardLeftView({el:'.left_container',model:dashboardLeft})
	
	dashboardLeftView.render()
	
})