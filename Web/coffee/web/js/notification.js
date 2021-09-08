function showNotification(message){
    if (window.Notification && Notification.permission === "granted") {
        var n = new Notification(message);
        n.onshow = function(){
            setTimeout(n.close.bind(n), 10000);
        }
        n.onclick = function(){
            return true;
        }
    }else{
        alert(message);
    }
}

function showAlert(message){
    alert(message);
}