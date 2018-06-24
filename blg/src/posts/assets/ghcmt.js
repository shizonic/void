function initComments(repo, issue) {
  apiURL="https://api.github.com/repos/" + repo + "/issues/" + issue + "/comments"
  newURL="https://github.com/" + repo + "/issues/" + issue + "#new_comment_field"

  document.GHCMT = new Vue({
    el: '#comments',
    data: {
      'list': {},
      'comments': {},
      'page': 1,
      'maxPage': 0,
      'show': 25
    },
    created: function() {
      this.fetchData()
    },
    filters: {
      moment: function (date) {
        return moment(date).fromNow()
      }
    },
    methods: {
      paginate: function() {
        if (this.list.length == 0) {
          this.maxPage = 0
          this.comments = {}
          return
        }
        cmts = this.list.slice((this.page -1) * this.show, this.page * this.show)
        this.maxPage = Math.ceil(this.list.length / this.show)
        this.comments = cmts
      },

      fetchData: function() {
        var xhr = new XMLHttpRequest()
        var self = this
        xhr.open('GET', apiURL)
        xhr.setRequestHeader('Accept', 'application/vnd.github.v3.html+json')
        xhr.onload = function() {
          self.list = JSON.parse(xhr.responseText).reverse()
          self.paginate()
        }
        xhr.send()
      }
    },

    watch: {
      page: function(){this.paginate()},
      show: function(){this.paginate()}
    }
  });
}
