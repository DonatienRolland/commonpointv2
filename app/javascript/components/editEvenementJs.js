function tabWithOutNewData(){
  const btns = document.querySelectorAll('.tabLevel')

  if (btns) {
    btns.forEach((btn) => {
      btn.addEventListener('click', function(){
        if (btn.dataset.target === "all") {
         var allLevel = document.querySelectorAll(".userToAdd")
          allLevel.forEach((eachLevel) => {
            eachLevel.style.display = "block"
          })
        } else {
          var allLevel = document.querySelectorAll(".userToAdd")
          allLevel.forEach((eachLevel) => {
            eachLevel.style.display = "none"
          })
          var level = ".tab_" + btn.dataset.target
          var allSameLevel = document.querySelectorAll(level)
          allSameLevel.forEach((eachLevel) => {
            eachLevel.style.display = "block"
          })
        }
      })
    })
  }

}


export { tabWithOutNewData }

function boostedEvenement(){
  const btns = document.querySelectorAll('.tr-evenement')
  const header = document.querySelector('.tbl-header')
  var user_id = header.dataset.user
  var url = header.dataset.url
  if (header) {
    btns.forEach((btn) => {
      btn.addEventListener('click', function(){
        var evenement_id = String(btn.dataset.evenement)
        var boosted = String(btn.dataset.boosted)
        var params_value = {
          evenement_id: evenement_id,
          boosted: boosted,
          user_id: user_id
        }
        $.ajax({
          url: url,
          type: "GET",
          data: params_value,
          success: function() {
            if (boosted === "true") {
              btn.dataset.boosted = true
              btn.innerHTML = "Retrier"
            } else {
              btn.dataset.boosted = false
              btn.innerHTML = "Booster"

            }
          }
        })
      })
    })
  }
}
export { boostedEvenement }
