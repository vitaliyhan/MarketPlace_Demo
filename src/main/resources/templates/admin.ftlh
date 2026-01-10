<#import "blocks/template.ftlh" as t>
<@t.template user>
    `<h1 style="text-align: center">Панель администратора</h1>
    <hr>
    <#if !user.roles?seq_contains("ROLE_ADMIN")>
        <div class="alert alert-warning" role="alert">
            <h4 class="alert-heading">У вас нет прав администратора!</h4>
            <p>Нажмите кнопку ниже, чтобы получить права администратора:</p>
            <form action="/admin/become-admin" method="post" style="display: inline;">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" class="btn btn-warning" value="Стать администратором">
            </form>
        </div>
        <hr>
    <#else>
        <div class="mb-3">
            <form action="/admin/create-dummy-data" method="post" style="display: inline;">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" class="btn btn-success" value="Создать тестовые данные (20 товаров)">
            </form>
        </div>
        <hr>
    </#if>
    <table class="table table-hover table-dark">
        <tr>
            <th scope="col">Email</th>
            <th scope="col">Номер телефона</th>
            <th scope="col">Активность</th>
            <th scope="col">Роли</th>
            <th scope="col">Бан</th>
            <th scope="col">Редактирование</th>
            <th scope="col">Подробная информация</th>
        </tr>
        <#list users as user>
            <tr>
                <th>${user.email}</th>
                <th>${user.phoneNumber}</th>
                <th><#if user.active>true<#else>false</#if></th>
                <th><#list user.roles as role>${role}</#list></th>
                <th>
                    <form action="/admin/user/ban/${user.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" class="btn btn-light" value="Бан">
                    </form>
                </th>
                <th><a href="/admin/user/edit/${user.id}">Редактировние</a></th>
                <th><a href="/user/${user.id}">Подробная информация</a></th>
            </tr>
        <#else>
            <h3>Пользователей нет</h3>
        </#list>
    </table>
</@t.template>