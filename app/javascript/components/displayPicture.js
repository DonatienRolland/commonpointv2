function importAvatar(){
  const input = document.getElementById('picture-upload')
  let reader = new FileReader();
  const preview = document.getElementById('preview')

  function readUrl(){
    reader.onload = function(e){
      preview.src = e.target.result
    }
    reader.readAsDataURL(input.files[0])
  }
  if ( input != null) {
    input.addEventListener('change', function(){
      readUrl();
    })
  }

}
export { importAvatar }
