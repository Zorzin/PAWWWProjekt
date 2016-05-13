<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="contact">
    <div class="kontakt">
        <div class="wizytowka">
            <table id="maintable">
                <tr>
                    <th id="kolumna">
                        <h1>Projekt PAWWW</h1>
                        <h2>Szymon Bakunowicz </h2>
                        <h2>Marcin Bogdan </h2>
                        <h2>ul. Wiejska 12 </h2>
                        <h2>Białystok</h2>
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
