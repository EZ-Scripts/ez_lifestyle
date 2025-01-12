const app = new Vue({
    el: '#app',
    data: {
        lifeStyles : []
    },

    methods: {
        postMessage(name, table) {
            $.post(`https://${GetParentResourceName()}/${name}`, JSON.stringify(table));
        },

        play(id) {
            this.postMessage("play", {id : id});
            $("#app").fadeOut(500);
        }
    }
});

window.addEventListener('message', function(event) {
    var data = event.data;
    if (data.type === "open") {
        app.lifeStyles = data.lifeStyles;
        $("#app").css("display", "flex").hide().fadeIn(500);
    }else {
        $("#app").fadeOut(500);
    }
})
