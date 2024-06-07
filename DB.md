## SQLite 사용법

참고한 링크

##### [SQLite JDBC](https://velog.io/@zihoo/SQLite-JDBC)
##### [SQLite JSP 사용 시 참고 사항](https://blog.naver.com/haengro/40061270062)

### 데이터베이스 구조
#### member
| 키        | 타입          | 조건                          |
|----------|-------------|-----------------------------|
| ID       | INTERGER    | PRIMARY KEY, AUTO_INCREMENT |
| NAME     | VARCHAR(10) | NOT NULL                    |
| EMAIL    | VARCHAR(30) | NOT NULL                    |
| PASSWORD | VARCHAR(30) | NOT NULL                    |

#### todo
| 키        | 타입         | 조건                     |
|----------|------------|------------------------|
| NAME     | VARCHAR(20) | NOT NULL               |
| STATE    | VARCHAR(8) | NOT NULL               |
| OWNER_ID | INTEGER    | FOREIGN KEY member(ID) |

### JDBC 실행하기
```java

// JDBC 실행하기 위한 설정들
Class.forName("org.sqlite.JDBC");
Connection conn = DriverManager.getConnection("jdbc:sqlite:identifier.sqlite");
Statement statement = conn.createStatement();

// 작업할 SQL들
ResultSet query = statement.executeQuery("SELECT * FROM member");

while (query.next()) {
    int id = query.getInt("ID");
    String name = query.getString("NAME");
    String email = query.getString("EMAIL");
    String password = query.getString("PASSWORD");

    out.println("id : " +
                id + "\n" +
                "name : " +
                name + "\n" +
                "email : " +
                email + "\n" +
                "password : " +
                password + "\n"
    );
    query.close();
    statement.close();
    conn.close();
}
```