import { func } from "prop-types";

function callNYT() {
  console.log("enter");
  const apiUrl =
    "http://api.nytimes.com/svc/topstories/v2/home.json?api-key=bAMpzCStmqUyHYP4WzTLyGxX7zsTBbGX";

  fetch(apiUrl)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      console.log(response);
      return response.json();
    })
    .then((data) => {
      console.log(data);
    })
    .catch((error) => {
      console.log("Error: ", error);
    });
}

function clickTopArticles() {
  const response = JSON.parse(callNYT());
  const results = response.results
  return results.map(function (result) {
    return (
        <div>{result.title}</div>
    )
  })
}

export default callNYT;