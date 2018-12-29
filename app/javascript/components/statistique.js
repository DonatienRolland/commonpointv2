function switchPeriod(){
  const chart = document.getElementById('chart-1')
  if (chart) {

    new Chartkick.LineChart("chart-1", chart.dataset.url, {
      name: "Utilisateurs Actifs",
      download: true,
      colors: ["#b00", "#666"],
      label: "Users",
      curve: false,
    })

    Chartkick.options = {
        colors: ["#b00", "#666"],
        label: "Users",
        curve: false,
        name: "Utilisateurs Actifs"
    }

    const input = document.getElementById('calendarPeriod')
    console.log(input)
    const typeOfPeriode = document.getElementById('typeOfPeriode')
    typeOfPeriode.addEventListener('change', function(){
      if (typeOfPeriode.value == "personnalisé") {
        input.classList.toggle('hidden')
      } else {
        input.classList.add('hidden')
      }

    })

    const btn = document.getElementById('sendPeriod')
    const presonnalizeDate = document.getElementById('presonnalize_date')
    btn.addEventListener('click', function(){


      var valuePeriod = typeOfPeriode.value
      var valuePersonnalize = presonnalizeDate.value
      var url
      if (valuePeriod === "mois") {
        url = "/charts/visitors_by_weeks"
      } else if (valuePeriod === "année") {
        url = "/charts/visitors_by_months"
      } else if (valuePeriod === "semaine") {
        url = "/charts/visitors_by_days"
      } else if (valuePersonnalize) {
        var start = Date.parse(valuePersonnalize.split(' to ')[0])
        var end = Date.parse(valuePersonnalize.split(' to ')[1])
        var oneDay = 24*60*60*1000;
        var diffDays = Math.round(Math.abs((end - start)/(oneDay)));
        if (diffDays < 8) {
          url = "/charts/visitors_by_days"
        } else if (diffDays < 31) {
          url = "/charts/visitors_by_weeks"
        } else {
          url = "/charts/visitors_by_months"
        }
        var params_stup = {
          starting: valuePersonnalize.split(' to ')[0],
          ending: valuePersonnalize.split(' to ')[1]
        }
      }
       $.ajax({
          url: url,
          type: "GET",
          data: params_stup,
          success: function() {
            new Chartkick.LineChart("chart-1", url)
          }
        })
    });
  }
}

export { switchPeriod }
