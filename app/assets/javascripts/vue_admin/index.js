function removeA(arr) {
  var what, a = arguments, L = a.length, ax;
  while (L > 1 && arr.length) {
      what = a[--L];
      while ((ax= arr.indexOf(what)) !== -1) {
          arr.splice(ax, 1);
      }
  }
  return arr;
}
var app = new Vue({
  el: "#index-container",
  data: {
    items: [],
    deleteList:[],
    controller: "#{controller_name}",
    action: "#{action_name}"
  },
  mounted: function(){
    var that;
    that = this;

    $.ajax({
      url: `/admin/${that.controller}.json`,
      success: function(res){
        that.items = res;
        console.log("It's ready!!");
      }
    });
  },
  computed:{
    checks: function(){
      return this.deleteList.length > 0
    },
    link: function(){
      return `/admin/${this.controller}/destroy_multiple?multiple_ids=[${this.deleteList}]`
    },
    checkItems: function(){
      return this.items.length > 0
    }
  },
  methods: {
    listDelete: function(user_id){
      var that = this;
      if(that.deleteList.includes(user_id)){
        removeA(that.deleteList, user_id)
      }else{
        that.deleteList.push(user_id)
      }
      console.log(that.deleteList);
    },
    selectAll: function(){
      var that = this;
      if (that.deleteList.length < that.items.length){
        that.items.map(function(item, idx){
          if (!that.deleteList.includes(item.id)) document.getElementById(`checkbox-${item.id}`).click();
            //console.log(that.deleteList.length + ' - ' + that.items.length);
            //console.log(`Este fue agregado ${item.id}`);
        });
      }else{
        that.items.map(function(item, idx){
          //console.log(`Este fue quitado ${item.id}`);
          document.getElementById(`checkbox-${item.id}`).click();
        });
      }
    }
    // deleteThem: function(){
    //   var that = this;
    //   //$.ajax({
    //   //  method: 'DELETE',
    //   //  url: "/admin/users?multiple_ids=[" + that.deleteList + "]",
    //   //  success: function(res){
    //   //    that.$el.$remove()
    //   //  }
    //   //})
    // }
  }
});
