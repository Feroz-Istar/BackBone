$(document).ready(function() {
	var DashboardRightModel= Backbone.Model.extend()
	var DashboardRightView= Backbone.View.extend({
		initialize: function(){
			this.render();
		},

		render:function(){
			var template = _.template(App.get(contextPath + this.model.get("pathUrl")));
			var html = template(this.model.toJSON());
			this.$el.append(html);
			return this;
		}
	})


	var dashboardRightView = new DashboardRightView({
		el : '#ongoing_task_card',
		model :new DashboardRightModel({
			baseURL : contextPath,
			pathUrl:"templates/dashboard/ongoing_task_card.html"
		}),

	})
	
	var dashboardRightView = new DashboardRightView({
		el : '#raise_issue_card',
		model :new DashboardRightModel({
			baseURL : contextPath,
			pathUrl:"templates/dashboard/raise_issue_card.html"
		}),

	})
	var dashboardRightView = new DashboardRightView({
		el : '#chat_card',
		model :new DashboardRightModel({
			baseURL : contextPath,
			pathUrl:"templates/dashboard/chat_card.html"
		}),

	})
	var dashboardRightView = new DashboardRightView({
		el : '#upcoming_meeting_card',
		model :new DashboardRightModel({
			baseURL : contextPath,
			pathUrl:"templates/dashboard/upcoming_meeting_card.html"
		}),

	})

})