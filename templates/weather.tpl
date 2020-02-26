<style>
  #mainen {
    background: radial-gradient(circle at 65% 15%, aqua, darkblue);
    height: 200px;
    width: 200px;
    /*display: none;*/
  }

  .map {
    font-family: Open Sans;
    font-size: 20px;
    height: 350px;
    width: 390px;
    margin-left: 0;
    margin-right: 0px;
    /*margin-bottom: 20px;*/
    text-align: center;
  }

  .map {
    background-image: linear-gradient(141deg, #9fb8ad 0%, #1fc8db 45%, #2cb5e8 75%);
  }

  #provaider {
    padding: 20px 0px 20px 0px;
  }

  #date {
    font-family: Open Sans;
    font-size: 20px !important;
  }
  .weather{
    text-align: center;
  }
</style>

<div class="row">
  <div class="form-group">
    <div id="map" class="map" style="border-radius:6px;box-shadow:0 0 10px rgba(0,0,0,0.5);">
      <div id="provaider">
        <div id="city-text">Город</div> <!--Город-->
        <div class="hidden" id="city-text4">Долгота</div><!--Долгота-->
        <div id="city-text6">Провайдер</div><!--Провайдер -->
      </div>
      <div id="times">
        <p>Сегодня: <strong><span id="date"></span><span id="clock"></span></strong></p>
      </div>
      <div class="row weather">
        <div class="col-md-4">Сегодня</div>
        <div class="col-md-4">Завтра</div>
        <div class="col-md-4">Послезавтра</div>
      </div>
    </div>
  </div>
</div>

<script>
    //вывод на страницу локализации
    function getWeather(locdata) {
        console.log("getWeather has been called.");
        var lat = locdata.latitude;
        var lon = locdata.longitude;
        var city = locdata.city;

        if (locdata) {
            console.log("success");
            jQuery("#city-text").html(locdata.city);
            jQuery("#city-text4").html(" Широта: " + locdata.latitude + " Долгота: " + locdata.longitude);
            jQuery("#city-text6").html(" Провайдер: " + locdata.org);
        } else {
            console.log("fail");
        }
    }

    //получение локализации
    var counter = 0;

    function getLocation() {
        console.log("Update# " + counter++);
        //call location api for location data
        return jQuery.ajax({
            url: "https://ipapi.co/jsonp/",
            dataType: "jsonp",
            type: "GET",
            async: "true",
        });
    }

    setTimeout(function () {
        getLocation().done(getWeather);
    }, 500);


    var date = new Date();
    var monthes = ['Января', 'Февраля', 'Марта', 'Апреля', 'Мая', 'Июня', 'Июля', 'Августа', 'Сентября', 'Октября', 'Ноября', 'Декабря'];
    var day = date.getDate(),
        month = monthes[date.getMonth()],
        year = date.getFullYear();
    var today = day + ' ' + month + ' ' + year+'p. ';
    document.getElementById("date").innerHTML = today;

    function clock(){
        var date = new Date(),
            hours = (date.getHours() < 10) ? '0' + date.getHours() : date.getHours(),
            minutes = (date.getMinutes() < 10) ? '0' + date.getMinutes() : date.getMinutes(),
            seconds = (date.getSeconds() < 10) ? '0' + date.getSeconds() : date.getSeconds();
        document.getElementById('clock').innerHTML = hours + ':' + minutes + ':' + seconds;
    }
    setInterval(clock, 1000);
    clock();

    this.getObjects = function (layer, err_callback, success_callback) {
        if (!layer['export_function']) return {};

        let url = selfUrl + '?header=2&get_index=' + layer['export_function'] + '&EXPORT_LIST=1&RETURN_JSON=1';
        if (FORM['OBJECT_ID'])
            url += '&OBJECT_ID=' + FORM['OBJECT_ID'];

        fetch(url)
            .then(function (response) {
                if (!response.ok)
                    throw Error(response.statusText);

                return response;
            })
            .then(function (response) {
                return response.json();
            })
            .then(result => async function (result) {
                ConfigurationObj.showObject(layer, result, err_callback, success_callback);
            }(result))
            .catch(function (error) {
                if (err_callback)
                    err_callback(layer['id']);
            });
    };

</script>