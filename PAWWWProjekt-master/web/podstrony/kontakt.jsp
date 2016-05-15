<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage" %>
<script>
var xmlhttp = new XMLHttpRequest();
var url = "kontakt.txt";

xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var myArr = JSON.parse(xmlhttp.responseText);
        myFunction(myArr);
    }
};
xmlhttp.open("GET", url, true);
xmlhttp.send();

function myFunction(arr) {
    var out = "<h1>Projekt PAWWW</h1>";
    var i;
    for(i = 0; i < arr.length; i++) {
        out += '<h2>' + 
        arr[i].display + '</h2>';
    }
    document.getElementById("kolumna").innerHTML = out;
}
</script>
<div id="contact">
    <div class="kontakt">
        <div class="wizytowka">
            <table id="maintable">
                <tr>
                    <th id="kolumna">
                    </th>
                    <th>
                        <div id="formularz">
                            <form action="mail.php" method="POST" class="form">

                                <p class="subject">
                                    <input type="text" name="subject" id="subject" placeholder="Tytuł" />
                                </p>

                                <p class="email">
                                    <input type="email" name="email" id="email" placeholder="email@example.pl" />
                                </p>

                                <p class="text">
                                    <textarea name="text" placeholder="Treść wiadomości" /></textarea>
                                </p>

                                <p class="submit">
                                    <input type="submit" value="Wyślij" />
                                </p>
                            </form>
                        </div>
                    </th>
                </tr>
            </table>
        </div>

    </div>
</div>
