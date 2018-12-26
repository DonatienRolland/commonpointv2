


const liens = document.querySelectorAll('.highcharts-credits')
const saves = document.querySelectorAll('.highcharts-exporting-group')
if (liens) {
  liens.forEach((lien) => {
    lien.innerHTML = ""
  })
}
if (saves.length > 1) {
  saves.forEach((save) => {
    save.innerHTML = ""
  })
}
