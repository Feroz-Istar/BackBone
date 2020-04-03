$(document).ready(function() {

	var contextPath = $('body').data('baseurl')
	window.App = {

		get : function(url) {
			var data = "<h1> failed to load url : " + url + "</h1>";
			console.log(url)
			$.ajax({
				async : false,
				url : url,
				dataType : "text",

				success : function(response) {
					data = response;
				}
			});
			return data;
		}
	}
	PipelineObj = [ {
		id : 127,
		name : 'Pipeline 01',
		stages : [ {
			id : 1,
			name : 'stage 01',
		}, {
			id : 2,
			name : 'stage 02',
		}, {
			id : 3,
			name : 'stage 03',
		}, {
			id : 4,
			name : 'stage 04',
		} ]
	}, {
		name : 'JoJo-Pipeline',
		stages : [ {
			id : 1,
			name : 'stage 01',
		}, {
			id : 2,
			name : 'stage 02',
		}, {
			id : 3,
			name : 'stage 03',
		}, {
			id : 4,
			name : 'stage 04',
		}, {
			id : 5,
			name : 'stage 05',
		}, {
			id : 6,
			name : 'stage 06',
		}, {
			id : 7,
			name : 'stage 07',
		}, {
			id : 8,
			name : 'stage 08',
		} ]
	}, {
		name : 'Pipeline 03'

	} ]
	var pipelienCount = 0;
	var PipelineCarouselModel = Backbone.Model.extend();
	var PipelineCarouselView = Backbone.View.extend({
		events : {
			"click #pipeline-right" : "pipelineRight",
			"click #pipeline-left" : "pipelineLeft"
		},
		pipelineLeft : function() {
			pipelienCount--;
			$('#pipeline-right').addClass('active')
			$('#pipeline-right').attr('disabled', false)
			if (pipelienCount == 0) {
				$('#pipeline-left').removeClass('active')
				$('#pipeline-left').attr('disabled', true)
				pipelienCount = 0;
			}
			this.model = new PipelineCarouselModel({
				pipeline : PipelineObj[pipelienCount],
				baseURL : contextPath
			})
			this.render();
			$("#pipeline-card").addClass('animated').addClass('fadeOutRight').addClass('faster');
			$("#pipeline-card").on('animationend', function() {
				$("#pipeline-card").removeClass('animated').removeClass('fadeOutRight').removeClass('faster');
				$("#pipeline-card").addClass('animated').addClass('fadeInLeft').addClass('faster');
				$("#pipeline-card").html(data);
				this.initializePipelineCarousel();
				$("#pipeline-card").on('animationend', function() {
					$("#pipeline-card").removeClass('animated').removeClass('fadeInLeft').removeClass('faster');

				});

			});

		},
		pipelineRight : function() {
			console.log("right")

			pipelienCount++;
			$('#pipeline-left').addClass('active')
			$('#pipeline-left').attr('disabled', false)
			if (pipelienCount >= PipelineObj.length - 1) {
				$('#pipeline-right').removeClass('active')
				$('#pipeline-right').attr('disabled', true)
			}
			this.model = new PipelineCarouselModel({
				pipeline : PipelineObj[pipelienCount],
				baseURL : contextPath
			})
			this.render();
			$("#pipeline-card").addClass('animated').addClass('fadeOutLeft').addClass('faster');
			$("#pipeline-card").on('animationend', function() {
				$("#pipeline-card").removeClass('animated').removeClass('fadeOutLeft').removeClass('faster');
				$("#pipeline-card").addClass('animated').addClass('fadeInRight').addClass('faster');
				$("#pipeline-card").html(data);
				this.initializePipelineCarousel();
				$("#pipeline-card").on('animationend', function() {
					$("#pipeline-card").removeClass('animated').removeClass('fadeInRight').removeClass('faster');
				});
			});

		},
		initializePipelineCarousel : function() {
			$('#pipeline_carousel').carousel({
				interval : 5000
			})
			$('#pipeline_carousel').on('slide.bs.carousel', function() {
				$('.pipeline-stage-name').html($('.pipeline_stage_radio_button.active').data('stage-name'))
			})
		},
		render : function() {

			var template = _.template(App.get(contextPath + 'templates/dashboard/pipelineCard.html'));
			var html = template(this.model.toJSON());
			this.$el.append(html);
			this.initializePipelineCarousel();
			return this;
		}
	})
	

	var pipelineCarouselModel = new PipelineCarouselModel({
		pipeline : PipelineObj[0],
		baseURL : contextPath
	})

	var pipelineCarouselView = new PipelineCarouselView({
		el : '#pipeline-card',
		parentEl : '.pipeline-card-parent',
		model : pipelineCarouselModel
	})

	pipelineCarouselView.render()
	
	//------------------------------------------------->
	
	//--------------TEAM CARDS
	
	teamObj=[
		{
			name:'Team 01',
			users:[{name:'hello'},{name:'nice'},{name:'to'},{name:'meet'},{name:'you'}]
		},{
			name:'Team 02',
			users:[{name:'nice'},{name:'to'},{name:'meet'},{name:'you'}]
		},{
			name:'Team 03',
			users:[{name:'hello'},{name:'nice'},{name:'to'},{name:'meet'},{name:'you'},{name:'to'}]
		}
	]
	
	var TeamCarouselModel= Backbone.Model.extend()
	var TeamCarouselView= Backbone.View.extend({
		render:function(){
			var template = _.template(App.get(contextPath + 'templates/dashboard/teamCard.html'));
			var html = template(this.model.toJSON());
			this.$el.append(html);
			return this;
		}
	})
	var teamCarouselModel = new TeamCarouselModel({
		team : teamObj[0],
		baseURL : contextPath
	})

	var teamCarouselView = new TeamCarouselView({
		el : '#team-card',
		model : teamCarouselModel
	})

	teamCarouselView.render()
	//---------------------------------------------------------------------->
	var BottomCarouselModel= Backbone.Model.extend()
	var BottomCarouselView= Backbone.View.extend({
		render:function(){
			var template = _.template(App.get(contextPath + 'templates/dashboard/centerBottomCard.html'));
			var html = template(this.model.toJSON());
			this.$el.append(html);
			return this;
		}
	})
				var headings=["Rockstars","Laggards","Trending Up","Trending Down"]

	var bottomCarouselModel = new BottomCarouselModel({
		headings:headings,
		baseURL : contextPath
	})

	var bottomCarouselView = new BottomCarouselView({
		el : '.top-bottom-agent-card',
		model : bottomCarouselModel
	})

	bottomCarouselView.render()
	
})