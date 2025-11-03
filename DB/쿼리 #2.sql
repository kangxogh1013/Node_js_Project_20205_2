-- 10. 아이템 테이블 생성

CREATE TABLE items(
	item_id INT AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(100) NOT NULL,
	DESCRIPTION TEXT,
	VALUE INT DEFAULT 0
)

-- 11. 아이템 데이터 삽입
INSERT INTO items(name , DESCRIPTION, VALUE) VALUES
('검', '기본 무기 ' , 10),
('방패', '기본 무기' , 15),
('물약 ', '체력을 회복 ', 5)

SELECT * FROM items

-- 13. 플레이어 인벤토리 테이블 생성

CREATE TABLE inventories(
	inventroy_id INT AUTO_INCREMENT PRIMARY KEY,
	player_id INT,
	item_id INT,
	quantity INT DEFAULT 1,
	FOREIGN KEY(player_id) REFERENCES players(player_id),
	FOREIGN KEY(item_id) REFERENCES items(item_id)

)

-- 14. 인벤 토리에 아이템 추가
INSERT INTO inventories (player_id, item_id, quantity) VALUES
(1,1,1), -- 1번 플레이어에 검 1개
(1,3,5), -- 1번 플레이어에 물약 5개
(2,2,1) -- 2번 플레이어에 방패 1개 players


-- 15. 플레이어의 인벤토리 조회
SELECT p.username , i. name, inv.quantity
FROM players p
JOIN inventories inv ON p.player_id = inv.player_id
JOIN items i ON inv.item_id = i.item_id

-- 1. 새로운 아이템 추가
INSERT INTO items(name , DESCRIPTION, VALUE) VALUES
('물약', '마나을 회복' ,20)

-- 2. 특정 플레이어의 인벤토리에 새 아이템 추가
INSERT INTO inventories (player_id, item_id, quantity) VALUES
(2,2,5)

-- 3. 가장 가치 있는 아이템 찾기
SELECT name , value FROM items ORDER BY value DESC LIMIT 1;

-- 17. 퀘스트 테이블 생성
CREATE TABLE quests(
	quest_id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	description TEXT,
	reward_exp INT DEFAULT 0,
	reward_item_id INT,
	FOREIGN KEY (reward_item_id) REFERENCES items(item_id)
)

-- 18. 퀘스트 데이터 삽입
INSERT INTO quests(title , description, reward_exp, reward_item_id) VALUES
('초보자 퀘스트 ' , '첫번째 퀘스트를 완료 하세요 ' , 100, 3),
('용사의 검 ' , '전설의 검을 찾 아보세요 ' , 500, 1)

-- 19. 플레이어 퀘스트 진행 상황 테이블
CREATE TABLE player_quests(
	player_id INT,
	quest_id INT,
	STATUS ENUM('시작 ' , '진행중 ' ,'완료 ') DEFAULT '시작 ',
	start_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	completed_at TIMESTAMP NULL,
	PRIMARY KEY (player_id, quest_id),
	FOREIGN KEY (player_id) REFERENCES players(player_id),
	FOREIGN KEY (quest_id) REFERENCES quests (quest_id)
)


-- 20. 플레이어에게 퀘스트 할당
INSERT INTO player_quests(player_id, quest_id) VALUES
(1,1),							-- 1번 플레이어에 게 초보자 퀘스트 할 당
(2,2)								-- 2번 플레이어에 게 용사의 검 퀘스트 할당

-- 21. 진행중인 퀘스트 진행
SELECT p.username , q.title, pq. STATUS
FROM players p
JOIN player_quests pq ON p.player_id = pq.player_id
JOIN quests q ON pq. quest_id = q.quest_id
WHERE pq.STATUS != '완료 '

-- 22. 퀘스트 완료 처리
UPDATE player_quests
SET STATUS = '완료', completed_at = CURRENT_TIMESTAMP
WHERE player_id = 1 AND quest_id = 1;

-- 1. 새로운 퀘스트 추가
INSERT INTO quests(title , description, reward_exp, reward_item_id) VALUES
('청소 퀘스트' , '마을을 청소해 보세요' , 200, 2)

-- 2. 특정 플레이어의 모든 퀘스트 상태 조회
SELECT q.title , pq.status FROM player_quests pq
JOIN quests q ON pq. quest_id = q. quest_id WHERE pq.player_id = 1

-- 3. 가장 많은 경험치를 주는 퀘스트 출력
SELECT title, reward_exp FROM quests ORDER BY reward_exp DESC LIMIT 1