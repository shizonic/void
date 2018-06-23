function initComments(repo, issue) {
  apiURL="https://api.github.com/repos/" + repo + "/issues/" + issue + "/comments";
  newURL="https://github.com/" + repo + "/issues/" + issue + "#new_comment_field";

  var request = new XMLHttpRequest();
  request.open('GET', apiURL, true);
  request.setRequestHeader('Accept', 'application/vnd.github.v3.html+json');
  
  request.onload = function() {
    cmtDiv=document.querySelectorAll('#comments');
    if (this.status >= 200 && this.status < 400) {
      var data = JSON.parse(this.response);
      data = data.reverse(); /// display latest first
      if (data.length == 0) {
        data[0] = [];
        data[0]['user'] = [];
        data[0]['user']['avatar_url'] = 'https://picturepan2.github.io/spectre/img/spectre-logo.svg';
        data[0]['user']['login'] = 'Empty';
        data[0]['body_html'] = 'Be the first to comment!';
      }
      console.log(data);
      //data = data.slice(0,25); // only display 25
      cmt='';
      cmt+='<div class="panel">';
      cmt+='<div class="panel-header">';
      cmt+='<div class="panel-title">';
      cmt+='<h4>Comments</h4>';
      cmt+='<div class="divider"></div>';
      cmt+='<p><a href="' + newURL + '"><button class="btn">Write Comment</button></a></p>';
      cmt+='</div>';
      cmt+='</div>';
      cmt+='<div class="panel-body">';
      data.forEach(function(item, i){
        t='<div class="tile">';
        t+='<div class="tile-icon"><figure class="avatar"><img src="' + item['user']['avatar_url'] + '" /></figure></div>';
        t+='<div class="tile-content">';
        t+='<p class="tile-title text-bold">' + item['user']['login'] + '</p>';
        t+='<p class="tile-subtitle">' + item['body_html'] + '</p>';
        t+='</div>';
        t+='</div>';
        cmt+=t;
      });
      cmt+='</div>';
      cmt+='</div>';
      cmtDiv[0].innerHTML+=cmt;
    } else {
      cmtDiv[0].innerHTML='<span class="text-error">There was an issue loading the comments!</span>';
    }
  };

  request.send();
}
