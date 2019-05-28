var remainDay = [];
var startDay = [];
var clockq = [];
var time_end = true;
var moved_to_live = false;
var close_auction = false;
var timeinterval = [];
var preauctioninterval = [];



function call_live_timmer(id) {
  var deadline = startDay[id].value;
  initializeLiveClock(clockq[id], deadline, id);
}

function getTimeRemaining(t) {
  var seconds = Math.floor((t / 1000) % 60);
  var minutes = Math.floor((t / 1000 / 60) % 60);
  var hours = Math.floor((t / (1000 * 60 * 60)) % 24);
  var days = Math.floor(t / (1000 * 60 * 60 * 24));
  return {
    'total': t,
    'days': days,
    'hours': hours,
    'minutes': minutes,
    'seconds': seconds
  };
}

function initializeLiveClock(id, endtime, case_id) {

  var gg = 0;
  var date_org = 0;
  function updateClock() {
    if($('meta[name=server_time]').attr("content") != ''){
      $('#loading_spinner').hide();
      var date_one = new Date(endtime);
      // var date_two = new Date($('meta[name=server_time]').attr("content"));
      var date_two = new Date();
      date_org = date_one.getTime() - date_two.getTime();
      var t = getTimeRemaining(date_org);
      var zeroday = (t.days > 0) ? (t.days == 1) ? t.days + ':' : t.days + ':' : '';
      var zerohours = ("0" + t.hours).slice(-2);
      var zerominutes = ("0" + t.minutes).slice(-2);
      var zeroseconds = ("0" + t.seconds).slice(-2);
      id.innerHTML = zeroday + zerohours + ':' + zerominutes + ':' + zeroseconds;
      if (t.total <= 0 && moved_to_live == false ) {
        clearInterval(preauctioninterval[case_id]);
        id.innerHTML = 'Starting....';
        var url = "/matches/" + case_id + "/live/move_to_live"
        $.ajax({
          type: 'get',
          url: url,
          success: function(data){
            clearInterval(preauctioninterval[case_id]);
            moved_to_live = true
          }
        });
        moved_to_live = true
        clearInterval(preauctioninterval[case_id]);
      }
      gg = 1;
      date_org = date_org-1000;
    }
    else{
      $('#loading_spinner').show();
    }
  }
  updateClock();
  preauctioninterval[case_id] = setInterval(updateClock, 1000);
}
