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
