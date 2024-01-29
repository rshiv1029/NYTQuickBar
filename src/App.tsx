import clickTopArticles from "./background/background";
function App() {
  return (
    <div>
      <h1>Hello, this is your extension!</h1>
      <div>
        <button id="myButton" onClick={clickTopArticles}>
          Grab Top Articles
        </button>
      </div>
      <div>
        <button id="Wordle">
          Wordle
        </button>
      </div>
      <script type="module" src="background.js"></script>
    </div>
  );
}

export default App;
