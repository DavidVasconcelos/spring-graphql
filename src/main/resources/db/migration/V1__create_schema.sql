-- Run this on database problemz

-- table definitions
CREATE SCHEMA IF NOT EXISTS problemz;
GRANT ALL ON SCHEMA problemz TO postgres;
SET search_path TO problemz;
DROP TABLE IF EXISTS userz_token;
DROP TABLE IF EXISTS solutionz;
DROP TABLE IF EXISTS problemz;
DROP TABLE IF EXISTS userz;

CREATE TABLE userz
(
    id                 uuid         NOT NULL,
    active             bool         NOT NULL default true,
    avatar             varchar(255) NULL,
    creation_timestamp timestamp    NOT NULL,
    display_name       varchar(100) NULL,
    email              varchar(100) NOT NULL,
    hashed_password    varchar(255) NOT NULL,
    username           varchar(50)  NOT NULL,
    UNIQUE (username),
    UNIQUE (email),
    PRIMARY KEY (id)
);

CREATE TABLE problemz
(
    id                 uuid         NOT NULL,
    "content"          text         NOT NULL,
    creation_timestamp timestamp    NOT NULL,
    tags               varchar(255) NOT NULL,
    title              varchar(255) NOT NULL,
    created_by         uuid         NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE problemz
    ADD CONSTRAINT problemz_userz_fk FOREIGN KEY (created_by) REFERENCES userz (id);

CREATE TABLE solutionz
(
    id                 uuid        NOT NULL,
    category           varchar(50) NOT NULL,
    "content"          text        NOT NULL,
    creation_timestamp timestamp   NOT NULL,
    vote_bad_count     int4        NOT NULL,
    vote_good_count    int4        NOT NULL,
    created_by         uuid        NOT NULL,
    problemz_id        uuid        NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE solutionz
    ADD CONSTRAINT solutionz_problemz_fk FOREIGN KEY (problemz_id) REFERENCES problemz (id);
ALTER TABLE solutionz
    ADD CONSTRAINT solutionz_userz_fk FOREIGN KEY (created_by) REFERENCES userz (id);

CREATE TABLE userz_token
(
    user_id            uuid         NOT NULL,
    auth_token         varchar(255) NOT NULL,
    creation_timestamp timestamp    NOT NULL,
    expiry_timestamp   timestamp    NOT NULL,
    PRIMARY KEY (user_id)
);

-- data samples

insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 'wjerson', 'wjerson@usatoday.com',
        'http://dummyimage.com/256x256.png/cc0000/ffffff', 'Wynne Jerson', '2023-01-23T10:54:27Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 'mrollin', 'mrollin@go.com', null, 'Muffin Rollin',
        '2023-01-11T06:46:44Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 'hdakin', 'hdakin@sina.com.cn',
        'http://dummyimage.com/256x256.png/cc0000/ffffff', 'Harman Dakin', '2023-01-04T08:27:38Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('68e62c31-fcd9-4d00-8859-1f34c629ccec', 'hbonass', 'hbonass@statcounter.com',
        'http://dummyimage.com/256x256.png/5fa2dd/ffffff', 'Helene Bonass', '2023-01-26T13:40:04Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 'klewcock', 'klewcock@go.com',
        'http://dummyimage.com/256x256.png/dddddd/000000', 'Krishnah Lewcock', '2023-01-03T05:35:35Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('f79eee59-f187-49b3-a204-17c7e361573c', 'dgoosey', 'dgoosey@cbslocal.com', null, 'Derek Goosey',
        '2023-01-27T21:27:52Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('fc5ef255-21bf-4552-9f58-dc97efac45df', 'twabb', 'twabb@typepad.com',
        'http://dummyimage.com/256x256.png/dddddd/000000', 'Tadeo Wabb', '2023-01-25T14:02:56Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('6dd5008f-039d-4318-9c47-36742447e078', 'grosin', 'grosin@about.me',
        'http://dummyimage.com/256x256.png/dddddd/000000', 'Glen Rosin', '2023-01-21T07:28:35Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('17fceead-5938-493b-b4b9-14726f2ddd9f', 'dstobo', 'dstobo@epa.gov',
        'http://dummyimage.com/256x256.png/5fa2dd/ffffff', 'Danit Stobo', '2023-01-01T00:18:39Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('e1dc7c97-540a-4788-92b3-a01b40cf0f11', 'rsparrowe', 'rsparrowe@cdbaby.com',
        'http://dummyimage.com/256x256.png/dddddd/000000', 'Ruddie Sparrowe', '2023-01-14T15:11:29Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('42e82e97-cac8-4253-9a7e-8e812cddcfd9', 'hkerfoota', 'hkerfoota@arizona.edu', null, 'Hedi Kerfoot',
        '2023-01-08T10:23:40Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('4888af09-3445-418e-87ca-67f7da19583e', 'ksingsb', 'ksingsb@surveymonkey.com',
        'http://dummyimage.com/256x256.png/cc0000/ffffff', 'Klement Sings', '2023-01-12T22:47:38Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 'rmegarrellc', 'rmegarrellc@omniture.com', null, 'Rutter Megarrell',
        '2023-01-10T07:11:22Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('44d588b6-5872-4c10-972d-8ac6e470f330', 'hworshalld', 'hworshalld@intelo.com',
        'http://dummyimage.com/256x256.png/ff4444/ffffff', 'Hillery Worshall', '2023-01-28T19:37:53Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('fd00a796-ac46-4978-9764-38eb226d4f55', 'abellsone', 'abellsone@google.de', null, 'Alastair Bellson',
        '2023-01-03T13:00:24Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('a2202602-438a-4657-a7c3-9027726c85cc', 'tlangleyf', 'tlangleyf@meetup.com',
        'http://dummyimage.com/256x256.png/dddddd/000000', 'Tyler Langley', '2023-01-11T11:53:44Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('9f9cc050-5c09-4059-bdc1-01a639a0cfab', 'jbrameg', 'jbrameg@dyndns.org', null, 'Josephine Brame',
        '2023-01-02T17:41:15Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('4c94f5f1-34c9-4d59-b558-06b83563713b', 'kspurdleh', 'kspurdleh@exblog.jp', null, 'Ki Spurdle',
        '2023-01-12T17:16:35Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 'wyosselevitchi', 'wyosselevitchi@usa.gov',
        'http://dummyimage.com/256x256.png/5fa2dd/ffffff', 'Winifred Yosselevitch', '2023-01-06T07:55:08Z',
        '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);
insert into userz (id, username, email, avatar, display_name, creation_timestamp, hashed_password, active)
values ('8352cf45-e8cc-4e09-8548-785723e941cb', 'jharmonj', 'jharmonj@parallels.com', null, 'Judon Harmon',
        '2023-01-11T14:32:43Z', '$2y$10$LC6wXDfzQi7DaTTDZFLQbejiWw8.kwiIaKfBVZs50SnWRRZMsM7M6', true);

insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('82b5e725-6ea9-421b-91a7-2704f7982ed3', '2023-02-11T01:54:38Z',
        'Open fracture of base of skull without mention of intracranial injury, unspecified state of consciousness',
        'Atherosclerosis of nonautologous biological bypass graft(s) of the extremities with rest pain', 'stomach',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('1f62b387-9277-4456-ab31-0e1cbb7488c0', '2023-02-22T05:06:14Z', 'Cellulitis and abscess of trunk',
        'Greenstick fracture of shaft of humerus, right arm, subsequent encounter for fracture with malunion', 'kidney',
        '44d588b6-5872-4c10-972d-8ac6e470f330');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('d1820f16-13ef-4e63-a13a-23e40eb9d3a0', '2023-02-17T12:51:46Z',
        'Demyelinating disease of central nervous system, unspecified',
        'Toxic effect of chewing tobacco, assault, sequela', 'lung,mouth', 'b9fd8643-2112-494d-bd34-01e8cc0d5b7a');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('8c5d12d4-1b89-484b-a85d-7108a8065cc6', '2023-02-08T11:00:36Z', 'Abdominal rigidity, unspecified site',
        'Toxic effect of hydrogen cyanide', 'skin', 'f79eee59-f187-49b3-a204-17c7e361573c');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('1a803a5d-c939-4146-9f6c-19ea5555517b', '2023-02-14T08:14:12Z',
        'Closed fracture of C5-C7 level with anterior cord syndrome', 'Other skateboard accident, subsequent encounter',
        'lung,skin', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('e1199a0e-1c7f-49a9-a8f0-521922133413', '2023-02-07T05:34:54Z',
        'Gamma globulin causing adverse effects in therapeutic use',
        'Osteopathy in diseases classified elsewhere, right forearm', 'eye', '9f9cc050-5c09-4059-bdc1-01a639a0cfab');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('0f7f13c3-dc9e-4fb5-9578-84668f803a19', '2023-02-02T17:08:44Z',
        'Intestinal infection due to enterotoxigenic E. coli',
        'Other nondisplaced fracture of lower end of left humerus, subsequent encounter for fracture with nonunion',
        'heart', '17fceead-5938-493b-b4b9-14726f2ddd9f');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('97e98c5c-8787-49b6-99a1-9e7a8db84d5e', '2023-02-21T14:10:14Z', 'Hereditary sensory neuropathy',
        'Bent bone of left radius, subsequent encounter for open fracture type IIIA, IIIB, or IIIC with delayed healing',
        'lung,heart', 'bd9d67a2-57ee-4564-b9a6-e82db487b4eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('25795c0b-9ae0-4302-af55-e14074184821', '2023-02-21T02:35:37Z', 'Calcification and ossification, unspecified',
        'Person on outside of bus injured in noncollision transport accident in nontraffic accident, initial encounter',
        'skin,stomach,heart', 'b9fd8643-2112-494d-bd34-01e8cc0d5b7a');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('392a8d50-c44a-4f4c-ad15-81fc77c849e8', '2023-02-12T13:20:28Z',
        'Antepartum hemorrhage associated with coagulation defects, delivered, with or without mention of antepartum condition',
        'Other air transport accident involving military aircraft, initial encounter', 'lung,eye,heart',
        'a2202602-438a-4657-a7c3-9027726c85cc');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('7449d121-31ee-4789-91ca-e2e740e92067', '2023-02-19T20:45:41Z',
        'Undersocialized conduct disorder, aggressive type, unspecified',
        'Derangement of unspecified medial meniscus due to old tear or injury, unspecified knee', 'nose,eye,mouth',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('96e04c30-cbda-4fa1-9956-e0557a2329cb', '2023-02-24T07:17:41Z',
        'Simple type schizophrenia, chronic with acute exacerbation',
        'External constriction of left back wall of thorax, subsequent encounter', 'kidney,heart',
        '17fceead-5938-493b-b4b9-14726f2ddd9f');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('29b0f439-0efe-4747-a4d7-f985f3dbed77', '2023-02-05T13:55:47Z',
        'Machinery accident in water transport injuring water skier',
        'Postprocedural adrenocortical (-medullary) hypofunction', 'kidney,skin,stomach',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89', '2023-02-21T04:07:52Z', 'Compartment syndrome, unspecified',
        'Unspecified pedal cyclist injured in collision with two- or three-wheeled motor vehicle in nontraffic accident, initial encounter',
        'lung,stomach', '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('bc806e1a-d3ed-4381-90f0-45e5408788bd', '2023-02-21T04:34:13Z',
        'Cortex (cerebral) laceration with open intracranial wound, with prolonged [more than 24 hours] loss of consciousness and return to pre-existing conscious level',
        'Sepsis of newborn due to other staphylococci', 'nose', '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('3215a35b-8596-44e3-9ec7-e112c8412b2e', '2023-02-04T10:13:35Z', 'Other allergy, other than to medicinal agents',
        'Unspecified open wound of unspecified external genital organs, male, initial encounter', 'eye,nose,stomach',
        'fc5ef255-21bf-4552-9f58-dc97efac45df');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('de86cbcf-6fd8-49d0-a5cb-305fcc4820f1', '2023-02-24T19:04:02Z', 'Family history of other blood disorders',
        'Unspecified open wound of scrotum and testes', 'ear,stomach', 'f79eee59-f187-49b3-a204-17c7e361573c');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('6d2dc4cb-5594-4bd6-b6b3-3a025622e8de', '2023-02-03T13:02:40Z',
        'Mechanical complication due to peritoneal dialysis catheter',
        'Displacement of internal fixation device of left femur, initial encounter', 'lung,eye,heart',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('9f53d7be-4f16-4666-9c06-655610aabf85', '2023-02-09T12:25:30Z', 'Toxic effect of liquefied petroleum gases',
        'Pyemic and septic embolism in pregnancy', 'kidney,skin,stomach', '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4', '2023-02-16T12:17:30Z', 'Unspecified monoarthritis, shoulder region',
        'Crohn''s disease, unspecified, with complications', '', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('be760e90-8eba-464c-bc7b-7ae5577cbe83', '2023-02-20T14:46:24Z', 'Congenital night blindness',
        'Toxic effect of herbicides and fungicides, undetermined, initial encounter', 'eye,stomach',
        '4888af09-3445-418e-87ca-67f7da19583e');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('80bcd2ee-3cf1-4b3e-9b2e-927840840c8d', '2023-02-16T07:41:11Z',
        'Neoplasm of uncertain behavior of bone and articular cartilage',
        '3-part fracture of surgical neck of unspecified humerus, subsequent encounter for fracture with routine healing',
        'skin', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('f96178fc-d8ef-45b9-8dc0-6d386ce3e1e2', '2023-02-01T15:21:31Z', 'Toxoplasmosis of other specified sites',
        'Hallucinogen dependence with intoxication, unspecified', 'lung,eye,ear,stomach',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('358493e2-7b47-466a-9577-5fe67b2357bf', '2023-02-10T09:51:59Z', 'Contracture of palmar fascia',
        'Late congenital syphilitic meningitis', 'stomach', 'b9fd8643-2112-494d-bd34-01e8cc0d5b7a');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('24948bee-0d2b-4b88-8e2b-3597b3759653', '2023-02-10T01:24:28Z',
        'Stevens-Johnson syndrome-toxic epidermal necrolysis overlap syndrome',
        'Strain of extensor muscle, fascia and tendon of right ring finger at forearm level, sequela',
        'eye,nose,stomach', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('a7201936-3e7f-4b99-9d61-b09ee15d59fb', '2023-02-12T01:27:07Z',
        'Suicide and self-inflicted poisoning by other utility gas',
        'Infections of bladder in pregnancy, third trimester', 'eye,stomach', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('b315c67e-7e6a-46a9-a072-4db97fbabd76', '2023-02-19T11:12:21Z',
        'Other noncollision motor vehicle traffic accident injuring passenger on motorcycle',
        'Other and unspecified overexertion or strenuous movements or postures, initial encounter', 'mouth',
        'fd00a796-ac46-4978-9764-38eb226d4f55');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('f778b158-c4eb-4b37-a57c-9c6576392318', '2023-02-12T18:12:21Z',
        'Open fracture of epiphysis. Lower (separation) of femur',
        'Counseling related to combined concerns regarding sexual attitude, behavior and orientation', 'ear,stomach',
        'a2202602-438a-4657-a7c3-9027726c85cc');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('2f5f35fa-2a39-449b-ab62-5d6fa62eac2f', '2023-02-08T23:47:02Z', 'Transverse vaginal septum',
        'Adverse effect of tetracyclines', 'lung,eye,heart', '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('1774142d-75e8-41c2-93c1-44546dd4cfab', '2023-02-24T21:26:39Z', 'Hemorrhage of rectum and anus',
        'Type 2 diabetes mellitus with proliferative diabetic retinopathy with traction retinal detachment not involving the macula, right eye',
        'kidney', '6dd5008f-039d-4318-9c47-36742447e078');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('6bff9d94-fa7e-4aab-a2ad-2b07273939e8', '2023-02-04T14:19:23Z',
        'Infection of amniotic cavity, delivered, with or without mention of antepartum condition',
        'Rheumatoid arthritis without rheumatoid factor, hip', 'heart', '4c94f5f1-34c9-4d59-b558-06b83563713b');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('a87795cf-c746-493e-8f93-d3d8502848b2', '2023-02-12T04:12:11Z', 'Other congenital anomalies of lung',
        'Displaced unspecified condyle fracture of lower end of left femur, subsequent encounter for open fracture type I or II with delayed healing',
        'heart', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('113ec8a1-8b64-44e8-914a-54fb75a9f2dd', '2023-02-06T01:40:27Z', 'Coccidioidal meningitis',
        'Other specified injury of unspecified blood vessel at forearm level, unspecified arm, sequela',
        'lung,eye,ear,stomach', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('11b5d66f-a157-40f5-8b8a-924026b1ed01', '2023-02-21T06:44:28Z', 'Family history of polycystic kidney',
        'Other physeal fracture of lower end of ulna, left arm, subsequent encounter for fracture with delayed healing',
        'lung,eye,ear,stomach', '42e82e97-cac8-4253-9a7e-8e812cddcfd9');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('71170f26-d3bf-47e6-ac66-7a7a09fe3f0f', '2023-02-13T17:35:13Z', 'Vitamin A deficiency with keratomalacia',
        'Heart transplant infection', 'stomach', 'bd9d67a2-57ee-4564-b9a6-e82db487b4eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('9c240f98-9306-4a0e-bc61-191775c9ad58', '2023-02-22T14:25:29Z',
        'Closed fracture of C5-C7 level with central cord syndrome',
        'Hodgkin lymphoma, unspecified, lymph nodes of multiple sites', 'heart',
        '17fceead-5938-493b-b4b9-14726f2ddd9f');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('5f6f0cf7-1106-44ec-b806-e9ed4b490f8b', '2023-02-18T21:03:15Z',
        '"Light-for-dates" with signs of fetal malnutrition, 1,250-1,499 grams',
        'Nondisplaced fracture of lateral condyle of left humerus, subsequent encounter for fracture with malunion',
        'lung,mouth', '4888af09-3445-418e-87ca-67f7da19583e');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('da30c55b-4df6-42e0-8466-dde1caf96546', '2023-02-04T05:12:10Z',
        'Unspecified adverse effect of other drug, medicinal and biological substance',
        'Snowboarder colliding with stationary object, subsequent encounter', 'skin',
        '4c94f5f1-34c9-4d59-b558-06b83563713b');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('7b57ffdd-6ff8-4fb0-b5b9-38d8ac32968f', '2023-02-21T21:17:31Z',
        'Other disorders of muscle, ligament, and fascia',
        'Other tear of medial meniscus, current injury, right knee, initial encounter', 'lung',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('20d81ca4-8961-49d0-b30e-3e4ee8b30834', '2023-02-01T01:25:31Z', 'Atypical depressive disorder',
        'Unstable burst fracture of third thoracic vertebra, initial encounter for open fracture',
        'kidney,skin,stomach', '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('0a2c770a-e96f-43af-87b9-5fa93d63ffe7', '2023-02-25T14:17:19Z', 'Other iatrogenic hypotension',
        'Fracture of condylar process of right mandible, subsequent encounter for fracture with nonunion',
        'kidney,mouth', 'b9fd8643-2112-494d-bd34-01e8cc0d5b7a');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('48661b6e-f1bc-4566-ad75-4419cda8256c', '2023-02-11T05:24:43Z', 'Convalescence following other treatment',
        '2-part nondisplaced fracture of surgical neck of left humerus, subsequent encounter for fracture with nonunion',
        'eye,lung,heart', 'bd9d67a2-57ee-4564-b9a6-e82db487b4eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('429dcd3b-0bfd-4909-a243-93e81a9cdc01', '2023-02-26T08:42:15Z',
        'Fall from other slipping, tripping, or stumbling',
        'Adverse effect of alpha-adrenoreceptor antagonists, initial encounter', 'skin',
        '6dd5008f-039d-4318-9c47-36742447e078');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('ab8e13a3-951e-4f33-9ef4-144d107965a5', '2023-02-25T14:03:42Z', 'Pathologic fracture, unspecified site',
        'Listeriosis', 'heart', '42e82e97-cac8-4253-9a7e-8e812cddcfd9');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('8ae8afad-8c17-497c-807a-0a0ce3626fb0', '2023-02-06T08:12:39Z', 'Atheroembolism of lower extremity',
        'Chronic tension-type headache, not intractable', 'skin,stomach,heart', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('4e92b433-3020-45ad-bebc-fa4c973e39bc', '2023-02-26T23:07:31Z', 'Diaphragmatic hernia with gangrene',
        'Corrosion of unspecified degree of unspecified ankle, subsequent encounter', 'kidney,mouth,skin',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('32669a4d-22e3-4a78-8988-b4ecbe30a1ab', '2023-02-07T16:37:43Z', 'Malignant neoplasm of vulva, unspecified site',
        'Traumatic rupture of other ligament of left middle finger at metacarpophalangeal and interphalangeal joint',
        'eye,mouth', '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('133f9b65-1fe0-4a58-bda8-aa218eb5fa22', '2023-02-20T12:27:52Z', 'Closed fracture of scapula, other',
        'Other complications associated with artificial fertilization', 'nose,eye,mouth',
        'fc5ef255-21bf-4552-9f58-dc97efac45df');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('1b0e6213-3dc1-46a2-90af-b85654c64297', '2023-02-11T09:41:14Z', 'Other closed fracture of lower end of humerus',
        'Congenital malformation of retina', 'lung,kidney', 'fc5ef255-21bf-4552-9f58-dc97efac45df');
insert into problemz (id, creation_timestamp, title, content, tags, created_by)
values ('401c0722-6032-4228-a0ca-e830695a414c', '2023-02-14T03:16:32Z',
        'Subdural hemorrhage following injury with open intracranial wound, with concussion, unspecified',
        'Burn of first degree of unspecified shoulder, initial encounter', 'lung,heart',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec');

insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('703c0349-b3fb-4eec-a7bc-d263e45568bd', '2023-03-04T20:21:10Z',
        'Occlusion of Middle Esophagus with Extraluminal Device, Percutaneous Endoscopic Approach', 'REFERENCE',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 3, 1, '35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('95311a3a-8c76-4d0e-b4b3-687bfb1d0c8e', '2023-04-15T01:10:41Z',
        'Drainage of Left Shoulder Joint, Percutaneous Approach, Diagnostic', 'EXPLANATION',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 5, 0, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0d187e09-9f20-4e56-b30e-afadcce624d5', '2023-04-02T19:08:37Z',
        'Dilation of Left Renal Artery, Bifurcation, with Intraluminal Device, Open Approach', 'EXPLANATION',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 10, 2, '133f9b65-1fe0-4a58-bda8-aa218eb5fa22');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('2399fb2e-dae5-40c5-91e6-7d56b81fe9c4', '2023-03-08T10:00:50Z',
        'Replacement of Left Finger Phalanx with Autologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', 'f79eee59-f187-49b3-a204-17c7e361573c', 4, 2, '6bff9d94-fa7e-4aab-a2ad-2b07273939e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0b2f8199-640d-4e58-917a-94701f230cb8', '2023-03-19T11:01:17Z',
        'Removal of Drainage Device from Stomach, Percutaneous Approach', 'EXPLANATION',
        '6dd5008f-039d-4318-9c47-36742447e078', 6, 0, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('beab787c-c240-43fd-a66f-56476b470547', '2023-03-21T07:55:25Z',
        'Insertion of Other Device into Right Pleural Cavity, Percutaneous Approach', 'REFERENCE',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 4, 3, '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('423a4d97-baa0-492b-a9a1-90a27f01fe7e', '2023-04-26T06:20:26Z',
        'Removal of Drainage Device from Abdominal Wall, Percutaneous Endoscopic Approach', 'REFERENCE',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 2, 1, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('27630c03-2298-4921-8bed-f4a30764fa30', '2023-04-16T16:10:09Z',
        'Drainage of Hyoid Bone with Drainage Device, Percutaneous Approach', 'REFERENCE',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 3, 1, 'd1820f16-13ef-4e63-a13a-23e40eb9d3a0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a0dbaeb1-96ac-4a08-822e-93d9a2f8e51a', '2023-03-26T18:17:14Z', 'Change Pressure Dressing on Left Lower Leg',
        'REFERENCE', '17fceead-5938-493b-b4b9-14726f2ddd9f', 4, 0, '8ae8afad-8c17-497c-807a-0a0ce3626fb0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1e331b34-1aa2-477b-b3f4-68666f084425', '2023-03-10T22:02:26Z',
        'Dilation of Intracranial Artery, Bifurcation, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '4888af09-3445-418e-87ca-67f7da19583e', 1, 3, '24948bee-0d2b-4b88-8e2b-3597b3759653');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b6ac40f0-5f65-43af-bffc-7b8d92269e33', '2023-04-06T04:08:55Z',
        'Transfer Facial Nerve to Oculomotor Nerve, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '4888af09-3445-418e-87ca-67f7da19583e', 8, 3, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e80db6b5-83f8-42c8-99ad-520057d06d70', '2023-04-24T02:59:10Z',
        'Insertion of Monitoring Device into Trachea, Open Approach', 'EXPLANATION',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 6, 0, 'bc806e1a-d3ed-4381-90f0-45e5408788bd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('742be510-83cd-4738-a745-99bfac2e0d05', '2023-03-08T04:54:26Z',
        'Bypass Right Subclavian Artery to Bilateral Upper Arm Artery with Synthetic Substitute, Open Approach',
        'EXPLANATION', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 4, 3, '9f53d7be-4f16-4666-9c06-655610aabf85');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8be08262-6ce8-49d8-99e0-8f7c472d1387', '2023-03-25T07:06:56Z',
        'Revision of Infusion Device in Bladder, Percutaneous Endoscopic Approach', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 4, 0, '8ae8afad-8c17-497c-807a-0a0ce3626fb0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a738400b-8497-4ec7-83d4-44c2f9b198c0', '2023-04-13T01:05:25Z',
        'Supplement Right Hand Tendon with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'REFERENCE', '4c94f5f1-34c9-4d59-b558-06b83563713b', 7, 0, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9483e845-b588-42c7-b576-f5e8a999cbf8', '2023-04-06T22:52:55Z',
        'Supplement Left Elbow Joint with Nonautologous Tissue Substitute, Open Approach', 'REFERENCE',
        '8352cf45-e8cc-4e09-8548-785723e941cb', 1, 3, '82b5e725-6ea9-421b-91a7-2704f7982ed3');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('34d29792-ed7d-4e00-a52c-e9dd4dfc6c0e', '2023-04-26T08:48:15Z',
        'Extirpation of Matter from Right Sublingual Gland, Percutaneous Approach', 'REFERENCE',
        '6dd5008f-039d-4318-9c47-36742447e078', 6, 2, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('334b4a20-f4bd-4400-baec-618b78076d04', '2023-03-18T23:15:25Z',
        'Excision of Left Acetabulum, Percutaneous Endoscopic Approach', 'REFERENCE',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 5, 1, '80bcd2ee-3cf1-4b3e-9b2e-927840840c8d');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('bb46ab17-f5ef-4439-95e5-c1d0ac9c0a5a', '2023-03-12T22:51:57Z',
        'Supplement Superior Vena Cava with Nonautologous Tissue Substitute, Open Approach', 'EXPLANATION',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 7, 3, 'be760e90-8eba-464c-bc7b-7ae5577cbe83');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('777ce730-2f1c-4339-bd2d-917144a211d2', '2023-04-29T05:52:11Z', 'Release Right Foot Tendon, External Approach',
        'REFERENCE', 'a2202602-438a-4657-a7c3-9027726c85cc', 10, 2, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('bed3ec19-7b60-40fd-80f7-9f3be03e565d', '2023-04-29T18:15:14Z',
        'Supplement Lower Back with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 9, 3, '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('65a97220-043e-479d-a0b4-adc2e0853fde', '2023-04-07T00:49:16Z',
        'Supplement Buccal Mucosa with Nonautologous Tissue Substitute, Open Approach', 'REFERENCE',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 8, 3, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d3414c83-7a96-4dc7-b459-60ae441920ce', '2023-03-29T04:15:10Z',
        'Extirpation of Matter from Left Hand Tendon, Open Approach', 'REFERENCE',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 3, 1, '133f9b65-1fe0-4a58-bda8-aa218eb5fa22');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7236904a-d7b0-4362-8881-f0c02dcae0b7', '2023-04-08T19:23:06Z',
        'Release Left Trunk Tendon, Percutaneous Approach', 'REFERENCE', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 2, 1,
        '3215a35b-8596-44e3-9ec7-e112c8412b2e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('642bc034-9169-4e19-912a-93ac84da8c3c', '2023-04-21T20:33:41Z',
        'Transfer Abducens Nerve to Accessory Nerve, Open Approach', 'EXPLANATION',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 0, 0, '32669a4d-22e3-4a78-8988-b4ecbe30a1ab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7ae8724a-dacc-42c0-a270-1840f0b3b7a0', '2023-03-30T07:11:59Z',
        'Resection of Right Thorax Muscle, Open Approach', 'EXPLANATION', '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 4, 3,
        '5f6f0cf7-1106-44ec-b806-e9ed4b490f8b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b8143c00-745d-41ed-a1b1-f8a92afde2df', '2023-04-02T23:40:36Z',
        'Destruction of Right Elbow Bursa and Ligament, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 9, 3, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('560c958e-b742-4346-a9ad-a5bd41e26874', '2023-03-19T11:03:08Z',
        'Release Sacrococcygeal Joint, Percutaneous Endoscopic Approach', 'REFERENCE',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 9, 3, '24948bee-0d2b-4b88-8e2b-3597b3759653');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('21d2cee1-7116-4cce-80de-ddb3c7e2ef7b', '2023-04-21T20:16:47Z',
        'Drainage of Left Thumb Phalanx, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 4, 0, 'bc806e1a-d3ed-4381-90f0-45e5408788bd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('dc31d018-d8dc-4c19-8cb2-3a195a4ca1f8', '2023-04-04T01:47:29Z',
        'Drainage of Right Epididymis, Percutaneous Approach, Diagnostic', 'REFERENCE',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 5, 3, '6d2dc4cb-5594-4bd6-b6b3-3a025622e8de');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('55d61aa2-3697-4162-96e7-e7fe0de60b5c', '2023-03-22T06:48:35Z',
        'Reposition Lower Tooth with External Fixation Device, All, Open Approach', 'EXPLANATION',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 0, 2, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('15ca7df2-01ee-4aaa-8cbc-0f0e68d2daa3', '2023-03-05T13:32:19Z',
        'Chiropractic Manipulation of Lower Extremities, Long and Short Lever Specific Contact', 'EXPLANATION',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 1, 0, '7b57ffdd-6ff8-4fb0-b5b9-38d8ac32968f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d41988e9-001a-4893-abd4-99b6a3e12585', '2023-03-29T16:46:05Z',
        'Replacement of Right Lacrimal Bone with Nonautologous Tissue Substitute, Open Approach', 'EXPLANATION',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 7, 0, '8c5d12d4-1b89-484b-a85d-7108a8065cc6');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1d1d68de-b69c-4277-8c8f-ead87e7dc43f', '2023-04-29T17:58:14Z',
        'Supplement of Right Lower Arm Subcutaneous Tissue and Fascia with Synthetic Substitute, Open Approach',
        'EXPLANATION', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 9, 3, '1a803a5d-c939-4146-9f6c-19ea5555517b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a5e04272-ded4-4dd8-b457-241048e20c56', '2023-04-13T11:49:24Z',
        'Supplement Left Vocal Cord with Nonautologous Tissue Substitute, Via Natural or Artificial Opening',
        'EXPLANATION', '17fceead-5938-493b-b4b9-14726f2ddd9f', 0, 0, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('df5937be-05cf-4015-8161-7c21f1d69685', '2023-03-28T07:25:39Z',
        'Excision of Left Metacarpophalangeal Joint, Percutaneous Endoscopic Approach, Diagnostic', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 10, 3, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('33bf472b-3a7f-4e38-b6aa-f1ffa5013ae7', '2023-04-15T04:18:41Z',
        'Supplement Pulmonary Valve with Synthetic Substitute, Percutaneous Approach', 'EXPLANATION',
        'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 8, 3, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6500c660-9bc9-4dd6-97dd-aa87cd3b1f89', '2023-03-18T12:56:51Z',
        'Insertion of Radioactive Element into Right Upper Arm, Percutaneous Endoscopic Approach', 'REFERENCE',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 6, 2, '20d81ca4-8961-49d0-b30e-3e4ee8b30834');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('aacacbde-3f14-40f8-8e2e-cd3f1ea4983a', '2023-03-12T11:51:52Z',
        'Revision of Nonautologous Tissue Substitute in Right Elbow Joint, External Approach', 'EXPLANATION',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 6, 3, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8f0a521c-8f16-4483-91a5-066c7fb9cddd', '2023-04-03T02:44:17Z',
        'Vocational Activities and Functional Community or Work Reintegration Skills Assessment using Prosthesis',
        'EXPLANATION', 'f79eee59-f187-49b3-a204-17c7e361573c', 0, 0, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9d69660c-5090-4269-a327-6de202c104e3', '2023-04-06T06:13:00Z',
        'Bypass Descending Colon to Rectum with Autologous Tissue Substitute, Open Approach', 'EXPLANATION',
        '8352cf45-e8cc-4e09-8548-785723e941cb', 4, 2, '35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('170af1dd-0d58-45f2-9c09-00f0dda1a25c', '2023-03-11T00:26:04Z',
        'Creation of Aortic Valve from Truncal Valve using Nonautologous Tissue Substitute, Open Approach', 'REFERENCE',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 0, 2, '6d2dc4cb-5594-4bd6-b6b3-3a025622e8de');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d5c576fb-7704-48cb-8089-55eb24256682', '2023-04-01T16:06:09Z',
        'Supplement Left Radius with Autologous Tissue Substitute, Open Approach', 'REFERENCE',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 5, 2, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('56803545-a5b9-4e38-a3f1-90b9c26a8bf8', '2023-04-13T09:03:51Z',
        'Reposition Right Zygomatic Bone with Internal Fixation Device, Percutaneous Endoscopic Approach',
        'EXPLANATION', 'fd00a796-ac46-4978-9764-38eb226d4f55', 10, 2, 'f778b158-c4eb-4b37-a57c-9c6576392318');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('162bd03f-06a9-48b1-83cc-d11c7cd861e9', '2023-03-12T14:29:14Z', 'Release Left Neck Muscle, Open Approach',
        'EXPLANATION', 'f79eee59-f187-49b3-a204-17c7e361573c', 3, 1, '401c0722-6032-4228-a0ca-e830695a414c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8e9f76af-250e-4e13-bc04-1672c75ee9fc', '2023-04-05T01:29:09Z', 'Caregiver Training in Home Management',
        'REFERENCE', 'f79eee59-f187-49b3-a204-17c7e361573c', 9, 2, '1774142d-75e8-41c2-93c1-44546dd4cfab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('12b6d6ee-7579-4c6c-b142-7ca7787da38b', '2023-03-10T19:03:28Z',
        'Excision of Right Shoulder Region, Percutaneous Approach', 'REFERENCE', '17fceead-5938-493b-b4b9-14726f2ddd9f',
        2, 3, '7449d121-31ee-4789-91ca-e2e740e92067');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('3d32c4f8-8006-45fc-b8a9-6476b51832a8', '2023-03-14T10:57:37Z',
        'Extraction of Right Upper Arm Skin, External Approach', 'EXPLANATION', 'fc5ef255-21bf-4552-9f58-dc97efac45df',
        9, 0, '0a2c770a-e96f-43af-87b9-5fa93d63ffe7');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e40473bc-597f-42d0-a00a-6afbd00f8570', '2023-03-22T20:43:28Z',
        'Repair Left Internal Carotid Artery, Open Approach', 'EXPLANATION', '8352cf45-e8cc-4e09-8548-785723e941cb', 2,
        0, '82b5e725-6ea9-421b-91a7-2704f7982ed3');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9b3fd94f-7c14-4288-9fbf-d7bd04cb05a6', '2023-03-23T14:42:18Z',
        'Reposition Right Metacarpophalangeal Joint with External Fixation Device, External Approach', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 6, 3, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('13f1d1a7-e049-45b7-b377-764ba60b4f95', '2023-04-15T13:06:04Z',
        'Revision of Autologous Tissue Substitute in Female Perineum, External Approach', 'REFERENCE',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 3, 0, '7b57ffdd-6ff8-4fb0-b5b9-38d8ac32968f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9d1b290b-8a01-4a7f-bde2-5e8c1eac06dc', '2023-03-05T14:41:38Z',
        'Extraction of Left Tympanic Membrane, Percutaneous Endoscopic Approach', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 8, 1, '8c5d12d4-1b89-484b-a85d-7108a8065cc6');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8cd28a07-a03c-4f68-886c-d6178b850f0a', '2023-03-19T06:50:30Z',
        'Repair Left Trunk Muscle, Percutaneous Endoscopic Approach', 'REFERENCE',
        '4888af09-3445-418e-87ca-67f7da19583e', 3, 1, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7c182563-f98d-4484-ad7c-511e274689fc', '2023-03-06T23:39:04Z',
        'Supplement Right Vertebral Vein with Synthetic Substitute, Percutaneous Approach', 'EXPLANATION',
        '6dd5008f-039d-4318-9c47-36742447e078', 3, 0, '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8df23a79-1907-42b9-b2a5-7c1b77f70a21', '2023-04-02T10:50:07Z',
        'Restriction of Gastric Artery, Percutaneous Endoscopic Approach', 'REFERENCE',
        'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 3, 2, 'be760e90-8eba-464c-bc7b-7ae5577cbe83');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d0c3ed18-228d-4d81-b2af-5b3d13116e56', '2023-03-25T00:40:52Z',
        'Removal of Autologous Tissue Substitute from Lumbar Vertebral Joint, Percutaneous Approach', 'REFERENCE',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 3, 0, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7da9e45f-9bf1-4a42-9d41-8bd54254e95b', '2023-03-06T03:38:01Z',
        'Magnetic Resonance Imaging (MRI) of Whole Fetus using Other Contrast', 'EXPLANATION',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 5, 1, '1b0e6213-3dc1-46a2-90af-b85654c64297');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('04bf04c4-777c-49d2-ada9-4c3760078613', '2023-03-19T01:30:41Z',
        'Inspection of Right Ankle Joint, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 7, 1, '1b0e6213-3dc1-46a2-90af-b85654c64297');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('531ea934-7859-40d9-b53e-f7407a3730d7', '2023-04-09T18:23:24Z',
        'Replacement of Left Vitreous with Synthetic Substitute, Percutaneous Approach', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 0, 0, 'd1820f16-13ef-4e63-a13a-23e40eb9d3a0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c784f8e5-adf4-4239-a12b-231f94811dce', '2023-03-12T19:44:02Z',
        'Drainage of Right Ankle Joint with Drainage Device, Percutaneous Approach', 'REFERENCE',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 8, 1, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('2ec91c9b-9102-4420-a174-d79706deccb4', '2023-04-26T16:33:21Z',
        'Dilation of Hepatic Artery, Percutaneous Approach', 'REFERENCE', '68e62c31-fcd9-4d00-8859-1f34c629ccec', 8, 0,
        '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('85c0d957-6496-4852-92a4-509c55c57b78', '2023-04-03T11:15:24Z',
        'Bypass Descending Colon to Cutaneous with Autologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 3, 0, 'bc806e1a-d3ed-4381-90f0-45e5408788bd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('66035b4e-4a18-4c11-90d8-7733dbc6f31d', '2023-04-15T21:25:36Z',
        'Dilation of Left Subclavian Vein with Intraluminal Device, Open Approach', 'REFERENCE',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 5, 1, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('826a40a1-586c-4e83-b684-1fcb92ae8efa', '2023-03-13T05:57:24Z',
        'Revision of Autologous Tissue Substitute in Right Tarsal, Percutaneous Approach', 'EXPLANATION',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 6, 3, '0a2c770a-e96f-43af-87b9-5fa93d63ffe7');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5e76b6d2-ba1e-45fd-ad2a-ddacd0476f0c', '2023-04-16T19:49:21Z',
        'Fluoroscopy of Right Jugular Veins using Low Osmolar Contrast', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 1, 3, '29b0f439-0efe-4747-a4d7-f985f3dbed77');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d8ddc0ac-1292-4f98-b9c4-c96037d42f2f', '2023-03-26T10:25:40Z',
        'Dilation of Coronary Artery, Two Arteries with Two Drug-eluting Intraluminal Devices, Percutaneous Approach',
        'EXPLANATION', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 9, 2, '32669a4d-22e3-4a78-8988-b4ecbe30a1ab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('503bb47c-374e-4b74-8ea2-f58352bb07d2', '2023-04-02T17:34:34Z',
        'Insertion of Infusion Device into Pancreatic Duct, Via Natural or Artificial Opening Endoscopic',
        'EXPLANATION', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 5, 1, 'da30c55b-4df6-42e0-8466-dde1caf96546');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1e70eb84-0a20-4d3e-836a-02d2f48d8728', '2023-04-04T16:22:44Z',
        'Removal of Internal Fixation Device from Sternum, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 8, 1, '11b5d66f-a157-40f5-8b8a-924026b1ed01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1e6d1d0b-f291-427b-a180-0b5d543cb131', '2023-03-20T08:14:59Z',
        'Replacement of Head and Neck Tendon with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', '4c94f5f1-34c9-4d59-b558-06b83563713b', 10, 3, '29b0f439-0efe-4747-a4d7-f985f3dbed77');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a97aad3b-095b-4560-addd-9e278aab5110', '2023-04-19T05:31:06Z',
        'Insertion of Infusion Device into Splenic Artery, Open Approach', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 10, 3, '3215a35b-8596-44e3-9ec7-e112c8412b2e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('611e67a7-2c42-4732-91ba-7f2448884b71', '2023-04-18T19:20:31Z',
        'Bypass Splenic Artery to Right Renal Artery with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', 'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 1, 1, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1fa6f716-29f8-4f7c-b175-edb7cd2f6d1e', '2023-03-26T09:40:50Z',
        'Bypass Left Atrium to Right Pulmonary Vein with Synthetic Substitute, Percutaneous Endoscopic Approach',
        'REFERENCE', '8352cf45-e8cc-4e09-8548-785723e941cb', 0, 2, '35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b07bcec5-c9d9-4ce6-a01f-967171885afb', '2023-03-24T13:26:06Z',
        'Extirpation of Matter from Right Lower Arm Subcutaneous Tissue and Fascia, Percutaneous Approach',
        'EXPLANATION', '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 3, 0, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('114a9d8a-3cbd-47cf-962d-f1c6ae54c96e', '2023-03-24T21:28:59Z',
        'Bypass Left Femoral Artery to Left Femoral Artery with Synthetic Substitute, Open Approach', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 9, 3, '7b57ffdd-6ff8-4fb0-b5b9-38d8ac32968f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('39dfacfb-f5ff-436b-98d2-ec1875c3f97f', '2023-03-25T13:21:53Z',
        'Dilation of Right Foot Artery, Bifurcation, with Three Drug-eluting Intraluminal Devices, Percutaneous Endoscopic Approach',
        'REFERENCE', '6dd5008f-039d-4318-9c47-36742447e078', 10, 2, '9f53d7be-4f16-4666-9c06-655610aabf85');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('348f2986-3d6c-4b64-b2c2-26d7a8c773e0', '2023-04-14T18:49:49Z',
        'Division of Left Shoulder Muscle, Percutaneous Approach', 'REFERENCE', 'fc5ef255-21bf-4552-9f58-dc97efac45df',
        9, 1, '1a803a5d-c939-4146-9f6c-19ea5555517b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b56b26fa-05d2-4677-8089-6b5f5acf7314', '2023-03-03T00:12:03Z',
        'Occlusion of Right Hand Vein with Intraluminal Device, Open Approach', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 2, 1, '358493e2-7b47-466a-9577-5fe67b2357bf');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b6e3b47f-d388-4be4-b335-f1ed930e4d32', '2023-04-17T22:29:40Z',
        'Removal of Extraluminal Device from Heart, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 0, 1, 'f778b158-c4eb-4b37-a57c-9c6576392318');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('ef1bec46-bc2e-4dcd-a5aa-feb63f40603c', '2023-04-14T00:57:24Z',
        'Removal of Infusion Device from Right Finger Phalangeal Joint, Open Approach', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 7, 0, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('3917f7e8-79a8-4184-96ee-f1451bf3c355', '2023-04-01T18:14:50Z', 'Lower Arteries, Destruction', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 3, 1, '401c0722-6032-4228-a0ca-e830695a414c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('68c6ee82-db1b-4f4f-a61d-f51261914e5f', '2023-03-17T15:47:39Z', 'Hearing Screening Assessment', 'EXPLANATION',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 0, 3, '20d81ca4-8961-49d0-b30e-3e4ee8b30834');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9325d7a1-2047-4aed-bc50-1b8e43739d00', '2023-03-08T06:04:09Z',
        'Reposition Left Acromioclavicular Joint with Internal Fixation Device, Open Approach', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 8, 1, '1774142d-75e8-41c2-93c1-44546dd4cfab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('20de8cb3-e919-4d42-b2a5-71a9b3bf32ab', '2023-03-18T06:59:30Z', 'Inspection of Facial Bone, Open Approach',
        'EXPLANATION', 'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 6, 2, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('34dec6d0-ba55-461e-b0e0-1fe7b82eacbd', '2023-03-01T08:01:25Z',
        'Excision of Right Kidney Pelvis, Open Approach', 'EXPLANATION', '17fceead-5938-493b-b4b9-14726f2ddd9f', 0, 2,
        '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('70cfd1d2-5c93-4b54-a6d0-f5032259e635', '2023-04-20T09:11:30Z',
        'Supplement Right Fibula with Autologous Tissue Substitute, Percutaneous Approach', 'EXPLANATION',
        '8352cf45-e8cc-4e09-8548-785723e941cb', 10, 1, '24948bee-0d2b-4b88-8e2b-3597b3759653');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6a54a768-6d7c-425c-9807-151c700c36b4', '2023-03-28T02:48:21Z',
        'Range of Motion and Joint Mobility Treatment of Neurological System - Head and Neck using Orthosis',
        'REFERENCE', '8352cf45-e8cc-4e09-8548-785723e941cb', 7, 0, '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6afe43c1-b778-49f1-9794-4095677286d2', '2023-03-21T12:28:14Z',
        'Excision of Left Common Iliac Vein, Percutaneous Approach, Diagnostic', 'REFERENCE',
        'f79eee59-f187-49b3-a204-17c7e361573c', 0, 0, 'f778b158-c4eb-4b37-a57c-9c6576392318');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f917a924-7eb7-429b-800a-8915fb4d3279', '2023-03-01T19:43:50Z',
        'High Dose Rate (HDR) Brachytherapy of Brain using Californium 252 (Cf-252)', 'EXPLANATION',
        '8352cf45-e8cc-4e09-8548-785723e941cb', 2, 2, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('4c9be0b8-52fa-46de-8c07-605fe2de4640', '2023-04-11T20:07:57Z',
        'High Dose Rate (HDR) Brachytherapy of Esophagus using Iridium 192 (Ir-192)', 'EXPLANATION',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 8, 3, '133f9b65-1fe0-4a58-bda8-aa218eb5fa22');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('35b59cb2-4770-4d9c-9075-093e15581d62', '2023-03-31T00:37:55Z',
        'Irrigation of Upper GI using Irrigating Substance, Via Natural or Artificial Opening, Diagnostic',
        'EXPLANATION', 'a2202602-438a-4657-a7c3-9027726c85cc', 7, 3, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('fb6bbbf5-b754-4fbe-afe5-7ffae300aa83', '2023-04-07T05:37:15Z',
        'Alteration of Right Upper Leg with Synthetic Substitute, Percutaneous Approach', 'EXPLANATION',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 0, 3, '8c5d12d4-1b89-484b-a85d-7108a8065cc6');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('edf29a1d-3216-4074-bfb9-397391583ec0', '2023-04-27T01:58:21Z',
        'Drainage of Left Parotid Duct, Percutaneous Approach, Diagnostic', 'REFERENCE',
        'f79eee59-f187-49b3-a204-17c7e361573c', 9, 3, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('636e9d5b-52c8-439c-a180-ef159de1315e', '2023-03-29T13:59:17Z',
        'Dilation of Bilateral Fallopian Tubes, Via Natural or Artificial Opening Endoscopic', 'REFERENCE',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 10, 2, '9f53d7be-4f16-4666-9c06-655610aabf85');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5a079c6f-5f18-4920-8293-ee38bb2992e9', '2023-04-29T08:16:02Z',
        'Revision of Nonautologous Tissue Substitute in Lumbosacral Joint, Percutaneous Approach', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 7, 2, '401c0722-6032-4228-a0ca-e830695a414c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1e2702f8-d134-4937-9bf8-d97bf68c77b5', '2023-03-27T11:00:47Z',
        'Bypass Bilateral Vas Deferens to Left Epididymis with Synthetic Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 8, 3, '71170f26-d3bf-47e6-ac66-7a7a09fe3f0f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9f32193c-e79d-487a-92bd-5d80c0e1cde5', '2023-04-13T11:00:10Z',
        'Destruction of Common Bile Duct, Percutaneous Endoscopic Approach', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 10, 2, '11b5d66f-a157-40f5-8b8a-924026b1ed01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('ebe2a012-e978-4ff1-99bb-485968cf3b20', '2023-03-18T12:34:42Z',
        'Reattachment of Right Hand Muscle, Percutaneous Endoscopic Approach', 'REFERENCE',
        'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 4, 2, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5a9eddb3-0501-4ac1-9c8b-e39c44cc3411', '2023-04-29T20:43:04Z',
        'Supplement Right External Jugular Vein with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 10, 0, '9f53d7be-4f16-4666-9c06-655610aabf85');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0f633b4c-f3d1-489c-b91e-df55560fc2ee', '2023-03-10T09:52:12Z',
        'Plain Radiography of Left Single Mammary Duct using Other Contrast', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 6, 0, '24948bee-0d2b-4b88-8e2b-3597b3759653');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('eeb26383-ace4-4863-a320-43f33d7cb99c', '2023-04-01T19:25:33Z',
        'Revision of Infusion Device in Spleen, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 6, 3, '6bff9d94-fa7e-4aab-a2ad-2b07273939e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5c4efc3f-ce30-4415-866b-e6267e132c45', '2023-03-12T14:21:37Z',
        'Reposition Right Humeral Shaft, External Approach', 'REFERENCE', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 0, 0,
        '8ae8afad-8c17-497c-807a-0a0ce3626fb0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('dc347c58-307e-4213-bcd0-80809351a3c0', '2023-04-26T05:30:39Z', 'Reposition Cervical Nerve, Open Approach',
        'EXPLANATION', '4c94f5f1-34c9-4d59-b558-06b83563713b', 5, 2, 'be760e90-8eba-464c-bc7b-7ae5577cbe83');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('af16eacf-47dc-4ae5-9893-609ae41a02ff', '2023-04-02T12:18:48Z',
        'Replacement of Left Inner Ear with Synthetic Substitute, Open Approach', 'EXPLANATION',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 2, 1, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c6543972-e263-453e-aa5e-5b32d482875b', '2023-03-27T15:43:16Z',
        'Drainage of Left Thyroid Gland Lobe, Open Approach, Diagnostic', 'REFERENCE',
        'f79eee59-f187-49b3-a204-17c7e361573c', 1, 1, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('64c7a659-f891-49b9-9b40-1687ff5caae1', '2023-03-21T21:40:19Z',
        'Removal of Nonautologous Tissue Substitute from Upper Back, Percutaneous Approach', 'EXPLANATION',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 1, 3, '71170f26-d3bf-47e6-ac66-7a7a09fe3f0f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e7c6fc50-cc35-4bf6-b7d1-3ec3154450bc', '2023-03-31T02:36:39Z',
        'Drainage of Left Basilic Vein, Percutaneous Approach', 'EXPLANATION', 'f79eee59-f187-49b3-a204-17c7e361573c',
        4, 0, 'be760e90-8eba-464c-bc7b-7ae5577cbe83');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9250d144-cb95-4dbf-a1af-ffe5e5862034', '2023-04-19T00:44:44Z',
        'Insertion of Monitoring Device into Bladder, Via Natural or Artificial Opening', 'REFERENCE',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 10, 1, '6bff9d94-fa7e-4aab-a2ad-2b07273939e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('59e90eab-cfea-4a30-845a-094c5653a8dd', '2023-04-14T06:10:10Z',
        'Excision of Right Upper Lung Lobe, Open Approach, Diagnostic', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 10, 1, '80bcd2ee-3cf1-4b3e-9b2e-927840840c8d');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7513df02-a88f-4b95-8a81-f2e11402aa35', '2023-04-03T08:17:12Z',
        'High Dose Rate (HDR) Brachytherapy of Tongue using Iridium 192 (Ir-192)', 'REFERENCE',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 9, 0, '6d2dc4cb-5594-4bd6-b6b3-3a025622e8de');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('04810b30-e438-460f-81e8-6a23e4951493', '2023-03-15T10:53:32Z',
        'Drainage of Right Vertebral Artery, Percutaneous Endoscopic Approach, Diagnostic', 'REFERENCE',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 1, 0, '5f6f0cf7-1106-44ec-b806-e9ed4b490f8b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('fbcb939a-5cd6-46e1-b861-79b6b14cf51a', '2023-04-20T04:44:44Z',
        'Removal of Synthetic Substitute from Lumbar Vertebral Joint, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 7, 0, '96e04c30-cbda-4fa1-9956-e0557a2329cb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e0776577-020d-45df-908a-ee8c91f79738', '2023-04-28T13:36:33Z',
        'Bypass Left Greater Saphenous Vein to Lower Vein with Autologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'REFERENCE', 'a2202602-438a-4657-a7c3-9027726c85cc', 6, 0, 'd1820f16-13ef-4e63-a13a-23e40eb9d3a0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b0442b63-a3a0-4dd6-958a-4036cffd9a33', '2023-04-27T18:37:30Z',
        'Supplement Right Axilla with Synthetic Substitute, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 5, 1, '358493e2-7b47-466a-9577-5fe67b2357bf');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('07682c79-dfb4-4cb2-95a4-11353a95dc94', '2023-03-08T15:08:42Z',
        'Drainage of Nasal Septum, Percutaneous Approach, Diagnostic', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 0, 0, 'e1199a0e-1c7f-49a9-a8f0-521922133413');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('14ed660b-7eec-432d-9f27-cb36e2725827', '2023-04-17T00:41:29Z',
        'Computerized Tomography (CT Scan) of Left Hip using Other Contrast', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 9, 1, '11b5d66f-a157-40f5-8b8a-924026b1ed01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9a873d8a-3f58-4605-a551-0666f4bfcf98', '2023-03-03T11:34:32Z',
        'Removal of Feeding Device from Stomach, Open Approach', 'REFERENCE', 'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 7,
        2, '401c0722-6032-4228-a0ca-e830695a414c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f6bfb007-d2c7-4c77-a6b5-f092828e0599', '2023-04-23T22:16:43Z',
        'Removal of Nonautologous Tissue Substitute from Vagina and Cul-de-sac, Via Natural or Artificial Opening',
        'EXPLANATION', '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 3, 3, '8c5d12d4-1b89-484b-a85d-7108a8065cc6');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1eb17abe-f91f-4d8b-b420-176a1b91193d', '2023-03-26T14:38:13Z',
        'Supplement Right Acetabulum with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', '68e62c31-fcd9-4d00-8859-1f34c629ccec', 10, 1, 'a7201936-3e7f-4b99-9d61-b09ee15d59fb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0994ccc1-8895-453c-8c76-25d2b5aa103f', '2023-04-04T18:31:18Z',
        'Restriction of Left Axillary Lymphatic with Extraluminal Device, Percutaneous Approach', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 8, 0, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('57f7bf70-19bd-4382-b99a-56c1bb858136', '2023-04-08T00:55:55Z',
        'Revision of Internal Fixation Device in Right Tibia, Percutaneous Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 4, 2, '358493e2-7b47-466a-9577-5fe67b2357bf');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('db90c174-8ad7-448d-b869-8140c5650ccb', '2023-04-16T14:13:08Z',
        'Revision of Neurostimulator Lead in Left Innominate Vein, Percutaneous Endoscopic Approach', 'REFERENCE',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 6, 2, '7449d121-31ee-4789-91ca-e2e740e92067');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6f78ed76-54a5-4e57-80d6-33ea16944f7e', '2023-04-10T21:35:26Z',
        'Repair Stomach, Pylorus, Percutaneous Approach', 'REFERENCE', '6dd5008f-039d-4318-9c47-36742447e078', 10, 0,
        '133f9b65-1fe0-4a58-bda8-aa218eb5fa22');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6cd95e64-d2e6-41a6-aac1-d00962f44f7b', '2023-04-09T21:08:36Z',
        'Bypass Left Internal Iliac Artery to Foot Artery, Open Approach', 'REFERENCE',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 7, 2, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5df6554a-5ace-4262-ac0d-526c59c3bdd1', '2023-03-11T00:30:27Z',
        'Excision of Left Lower Lobe Bronchus, Percutaneous Approach, Diagnostic', 'REFERENCE',
        'f79eee59-f187-49b3-a204-17c7e361573c', 10, 3, '20d81ca4-8961-49d0-b30e-3e4ee8b30834');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('38af0b0e-2a4c-4343-bc7f-583d9008b417', '2023-04-07T19:39:28Z',
        'Release Lung Lingula, Via Natural or Artificial Opening', 'REFERENCE', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9',
        10, 1, 'da30c55b-4df6-42e0-8466-dde1caf96546');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('280ba762-60a6-4bb1-b1b7-b1153f4c94c9', '2023-04-01T13:12:27Z',
        'Drainage of Subarachnoid Space, Percutaneous Approach', 'REFERENCE', 'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 5,
        3, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7dcbbbdc-e091-41da-a8af-f97ec04fb9e3', '2023-04-18T03:09:22Z',
        'Occlusion of Descending Colon, Via Natural or Artificial Opening Endoscopic', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 4, 0, '1a803a5d-c939-4146-9f6c-19ea5555517b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0e6fd9ac-024b-4721-a367-4c15ad529505', '2023-03-22T21:40:52Z',
        'Revision of External Fixation Device in Right Finger Phalangeal Joint, Percutaneous Approach', 'EXPLANATION',
        '6dd5008f-039d-4318-9c47-36742447e078', 2, 2, '25795c0b-9ae0-4302-af55-e14074184821');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b4976d1f-d073-4450-a1c0-d6eee359eb1c', '2023-04-08T22:13:44Z',
        'Extirpation of Matter from Intracranial Artery, Bifurcation, Percutaneous Endoscopic Approach', 'REFERENCE',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 9, 2, 'a7201936-3e7f-4b99-9d61-b09ee15d59fb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1440ba45-db76-4765-b239-ee6ee8c5d6d1', '2023-03-18T06:42:44Z',
        'Transfer Left Lower Leg Muscle with Skin, Percutaneous Endoscopic Approach', 'REFERENCE',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 7, 1, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('689dae71-7bdb-445a-85a7-8759cf255c38', '2023-04-11T03:25:41Z',
        'Dilation of Right Internal Iliac Artery, Bifurcation, with Three Intraluminal Devices, Percutaneous Approach',
        'EXPLANATION', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 10, 1, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('cc4ee059-b473-42ae-a45c-28ee14dec3ec', '2023-03-19T03:22:38Z',
        'Supplement Left External Carotid Artery with Autologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'REFERENCE', '44d588b6-5872-4c10-972d-8ac6e470f330', 3, 1, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8a9f0d84-2b87-463b-b4de-0b3692b31049', '2023-04-23T19:08:42Z',
        'Dilation of Left Lower Lobe Bronchus with Intraluminal Device, Open Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 8, 2, '3215a35b-8596-44e3-9ec7-e112c8412b2e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('56901f96-52da-4694-84b0-7b65c1499b23', '2023-03-15T14:59:26Z',
        'Division of Right Occipital Bone, Percutaneous Approach', 'EXPLANATION',
        '4888af09-3445-418e-87ca-67f7da19583e', 1, 1, '0a2c770a-e96f-43af-87b9-5fa93d63ffe7');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6820f003-455d-4f72-9dd1-0083bb22d925', '2023-04-02T08:42:05Z',
        'Repair Lumbosacral Plexus, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 4, 1, '25795c0b-9ae0-4302-af55-e14074184821');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a599d155-7bdb-4644-9129-ff0d330998e1', '2023-04-25T20:32:59Z',
        'Removal of Synthetic Substitute from Sternum, Percutaneous Approach', 'REFERENCE',
        '4888af09-3445-418e-87ca-67f7da19583e', 1, 3, '7449d121-31ee-4789-91ca-e2e740e92067');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7c75b5e4-5d60-432c-af1f-559aae145f7b', '2023-04-01T01:29:59Z',
        'Insertion of External Fixation Device into Right Ulna, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 6, 0, '71170f26-d3bf-47e6-ac66-7a7a09fe3f0f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9234e282-4aca-4797-a11f-9fc10bb78854', '2023-03-27T15:13:46Z',
        'Revision of Drainage Device in Abdominal Wall, Percutaneous Approach', 'EXPLANATION',
        'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 9, 0, '9f53d7be-4f16-4666-9c06-655610aabf85');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('dc82ccd9-177d-4774-a2b3-94e824d86f38', '2023-03-07T20:13:40Z',
        'Restriction of Transverse Colon, Percutaneous Approach', 'EXPLANATION', '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb',
        8, 2, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0dbb8e8f-39b8-4435-9046-3bbc2699664a', '2023-04-26T12:35:31Z',
        'Supplement Right Breast with Synthetic Substitute, Open Approach', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 5, 1, '7449d121-31ee-4789-91ca-e2e740e92067');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('355a58bc-eaf7-4a02-ab03-076f2359561b', '2023-03-14T08:28:45Z',
        'Destruction of Right Renal Vein, Percutaneous Endoscopic Approach', 'REFERENCE',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 9, 0, 'be760e90-8eba-464c-bc7b-7ae5577cbe83');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('60e7a604-ba21-45b6-8772-f66364156cf1', '2023-03-31T00:33:51Z',
        'Fragmentation in Lingula Bronchus, External Approach', 'REFERENCE', 'a2202602-438a-4657-a7c3-9027726c85cc', 6,
        3, '48661b6e-f1bc-4566-ad75-4419cda8256c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('98ee8dd6-6c29-472d-b743-6ddc99cdb293', '2023-04-22T00:30:55Z', 'Reposition Left Ulna, Percutaneous Approach',
        'EXPLANATION', 'fd00a796-ac46-4978-9764-38eb226d4f55', 9, 2, 'd1820f16-13ef-4e63-a13a-23e40eb9d3a0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('84efdc7a-7121-46b0-afd2-bde2798b54f0', '2023-04-20T01:47:40Z', 'Drainage of Subarachnoid Space, Open Approach',
        'EXPLANATION', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 7, 1, '82b5e725-6ea9-421b-91a7-2704f7982ed3');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9732313f-8f2b-41f5-9aa9-f4ced0a70155', '2023-03-13T10:32:22Z',
        'Replacement of Right Lower Leg Skin with Synthetic Substitute, Full Thickness, External Approach',
        'EXPLANATION', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 8, 3, '29b0f439-0efe-4747-a4d7-f985f3dbed77');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('de1dfba4-fe15-4f5a-8097-69b7f86ced2d', '2023-03-17T16:39:06Z',
        'High Dose Rate (HDR) Brachytherapy of Thymus using Californium 252 (Cf-252)', 'EXPLANATION',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 9, 1, '1774142d-75e8-41c2-93c1-44546dd4cfab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('ab0646c7-c566-4a20-8097-607e27faff7a', '2023-03-14T21:30:02Z',
        'Inspection of Right Temporomandibular Joint, Percutaneous Approach', 'EXPLANATION',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 9, 0, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('dac920f6-c4d2-494c-a8b6-1763ee6dec16', '2023-03-09T11:24:47Z', 'Change Brace on Right Lower Leg',
        'EXPLANATION', '68e62c31-fcd9-4d00-8859-1f34c629ccec', 1, 1, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('28f6b3a9-fd1e-4e1e-9b83-23e87c8cb1f1', '2023-04-04T00:03:37Z',
        'Transplantation of Right Middle Lung Lobe, Allogeneic, Open Approach', 'EXPLANATION',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 1, 0, '5f6f0cf7-1106-44ec-b806-e9ed4b490f8b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7268573b-1d76-41b0-99c7-40b3a7a40f41', '2023-04-15T04:53:45Z', 'Oral Peripheral Mechanism Assessment',
        'REFERENCE', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 9, 1, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('ee4e2d38-7aad-49cf-bca9-013070dfde9a', '2023-04-04T17:23:58Z',
        'Magnetic Resonance Imaging (MRI) of Inferior Vena Cava', 'EXPLANATION', '68e62c31-fcd9-4d00-8859-1f34c629ccec',
        10, 1, 'f96178fc-d8ef-45b9-8dc0-6d386ce3e1e2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('71fc72dd-b3e2-4159-8fa0-dbfdc0a27b55', '2023-04-28T19:26:10Z',
        'High Dose Rate (HDR) Brachytherapy of Nasopharynx using Iridium 192 (Ir-192)', 'REFERENCE',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 9, 2, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('46889738-ad29-487d-a6dc-36165b83b326', '2023-03-24T15:04:52Z',
        'Drainage of Tongue, Palate, Pharynx Muscle, Percutaneous Approach', 'REFERENCE',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 10, 0, '48661b6e-f1bc-4566-ad75-4419cda8256c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5817f748-0146-4945-aca3-7146d817af00', '2023-04-09T00:35:32Z',
        'Excision of Right Radial Artery, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 6, 3, '6bff9d94-fa7e-4aab-a2ad-2b07273939e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('3b08106f-5e60-4de4-bc3c-4d987d5c1f38', '2023-03-16T14:53:01Z',
        'Removal of Extraluminal Device from Ureter, Percutaneous Endoscopic Approach', 'REFERENCE',
        'f79eee59-f187-49b3-a204-17c7e361573c', 5, 1, '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('35e19eeb-3b2e-442e-be8c-b525be004b88', '2023-04-02T19:31:49Z',
        'Removal of Monitoring Device from Spinal Canal, Open Approach', 'EXPLANATION',
        '6dd5008f-039d-4318-9c47-36742447e078', 2, 2, '25795c0b-9ae0-4302-af55-e14074184821');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0cb90687-afe9-478e-84bc-f00fa0f84f85', '2023-04-11T05:15:58Z', 'Release Uvula, Percutaneous Approach',
        'REFERENCE', 'f79eee59-f187-49b3-a204-17c7e361573c', 8, 1, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f779b27e-1992-4184-8d04-e6ace0bacab2', '2023-04-28T02:44:36Z',
        'Reposition Right Metacarpocarpal Joint, Open Approach', 'REFERENCE', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 9,
        1, '7449d121-31ee-4789-91ca-e2e740e92067');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('fe0b8503-f1f4-482c-96f1-23062ef73057', '2023-04-25T09:06:19Z',
        'Reposition Left Metatarsal-Phalangeal Joint with Internal Fixation Device, Percutaneous Approach',
        'EXPLANATION', '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 0, 2, '6bff9d94-fa7e-4aab-a2ad-2b07273939e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('20daa005-ad6c-4dd1-9486-ade6d83956a6', '2023-04-27T15:51:26Z', 'Repair Left Lower Femur, Open Approach',
        'REFERENCE', '68e62c31-fcd9-4d00-8859-1f34c629ccec', 5, 2, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f6005558-bd29-473c-a934-11f3214a14cf', '2023-03-29T03:13:54Z',
        'Destruction of Large Intestine, Via Natural or Artificial Opening Endoscopic', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 4, 3, 'b315c67e-7e6a-46a9-a072-4db97fbabd76');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8bab2d34-e02d-4bd0-be96-cc6a80e4cf4f', '2023-03-12T20:48:30Z',
        'Replacement of Right Middle Ear with Synthetic Substitute, Open Approach', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 9, 3, '0a2c770a-e96f-43af-87b9-5fa93d63ffe7');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c907117d-a539-4d0d-9f55-fbe700189006', '2023-04-18T08:12:14Z', 'Upper Bones, Destruction', 'EXPLANATION',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 1, 1, '1b0e6213-3dc1-46a2-90af-b85654c64297');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d36ccbe8-61f7-4504-8b65-19ac2419ab5e', '2023-03-25T23:42:31Z',
        'Removal of Autologous Tissue Substitute from Left Extraocular Muscle, Open Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 5, 2, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1fd4c501-d314-4819-bafc-98a5b634257c', '2023-04-08T05:37:39Z',
        'Fusion of Right Finger Phalangeal Joint with Autologous Tissue Substitute, Open Approach', 'EXPLANATION',
        '4888af09-3445-418e-87ca-67f7da19583e', 2, 2, '1a803a5d-c939-4146-9f6c-19ea5555517b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('145ae3f6-7a1c-4753-8b35-67c3bdcf8f68', '2023-04-27T20:30:42Z', 'Release Left Trunk Tendon, Open Approach',
        'EXPLANATION', '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 6, 0, 'f96178fc-d8ef-45b9-8dc0-6d386ce3e1e2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1ceae497-72a0-44e9-a37e-e80c29611f7f', '2023-04-09T19:40:04Z',
        'Drainage of Right Inguinal Lymphatic with Drainage Device, Percutaneous Approach', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 1, 3, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('35cf7347-ad95-4ae2-89c4-4694465cfa4a', '2023-04-03T12:18:17Z',
        'Orofacial Myofunctional Assessment using Other Equipment', 'REFERENCE', '6dd5008f-039d-4318-9c47-36742447e078',
        2, 3, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('821f2bf4-327d-4f47-ad28-d6a2292b69f0', '2023-04-22T18:33:15Z',
        'Supplement Left Index Finger with Synthetic Substitute, Percutaneous Endoscopic Approach', 'REFERENCE',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 1, 0, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('aab2b1c2-cd7c-4228-a6b7-ad86f3ac27d4', '2023-03-20T10:02:45Z',
        'Repair Femoral Nerve, Percutaneous Endoscopic Approach', 'EXPLANATION', '42e82e97-cac8-4253-9a7e-8e812cddcfd9',
        1, 0, 'e1199a0e-1c7f-49a9-a8f0-521922133413');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9c6d62fc-2e51-4710-b43a-ca75155e6a5f', '2023-04-28T09:02:45Z',
        'Reposition Left Temporomandibular Joint with Internal Fixation Device, Percutaneous Approach', 'REFERENCE',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 10, 3, '7449d121-31ee-4789-91ca-e2e740e92067');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c516d0b5-71b9-4e3f-9bf6-b1f2b8a84a51', '2023-03-30T00:38:34Z',
        'Supplement Right Hand Muscle with Autologous Tissue Substitute, Percutaneous Endoscopic Approach', 'REFERENCE',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 9, 3, 'd1820f16-13ef-4e63-a13a-23e40eb9d3a0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('3e979153-572c-480d-a69f-7afe0da071a2', '2023-04-12T09:28:00Z',
        'Dilation of Transverse Colon, Via Natural or Artificial Opening Endoscopic', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 4, 0, '29b0f439-0efe-4747-a4d7-f985f3dbed77');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('be3f4ba4-0aaa-4025-bbea-88dc95244a5a', '2023-03-02T23:32:31Z',
        'Revision of Nonautologous Tissue Substitute in Left Upper Extremity, Open Approach', 'REFERENCE',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 10, 3, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e9167b67-2e7d-4537-b9ec-3541cd373e8e', '2023-04-05T00:40:41Z',
        'Destruction of Right Eustachian Tube, Via Natural or Artificial Opening Endoscopic', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 1, 1, '32669a4d-22e3-4a78-8988-b4ecbe30a1ab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('2ecb9b75-96db-48f6-8703-b8c9e9533363', '2023-04-06T15:59:58Z',
        'Removal of Internal Fixation Device from Right Lower Femur, Percutaneous Endoscopic Approach', 'REFERENCE',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 1, 3, '32669a4d-22e3-4a78-8988-b4ecbe30a1ab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d0b1180d-30da-4469-8c76-ae96fd05f287', '2023-03-04T03:34:41Z',
        'Excision of Chest Subcutaneous Tissue and Fascia, Percutaneous Approach', 'EXPLANATION',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 3, 3, 'e1199a0e-1c7f-49a9-a8f0-521922133413');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('2b2437b7-da9b-472f-8cb3-c5452e5aa6d3', '2023-04-06T02:53:49Z',
        'Revision of Nonautologous Tissue Substitute in Lower Muscle, External Approach', 'EXPLANATION',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 8, 0, 'a7201936-3e7f-4b99-9d61-b09ee15d59fb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('59d242b0-f7de-43da-88a1-251609de26d8', '2023-04-10T18:22:30Z',
        'Plain Radiography of Right Single Mammary Duct using Low Osmolar Contrast', 'EXPLANATION',
        'a2202602-438a-4657-a7c3-9027726c85cc', 3, 2, '9f53d7be-4f16-4666-9c06-655610aabf85');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('489b5db1-f25a-4a7e-a961-b6cf2fb3a25f', '2023-03-25T07:35:02Z',
        'Removal of Intraluminal Device from Great Vessel, External Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 3, 2, 'bc806e1a-d3ed-4381-90f0-45e5408788bd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f8a6602e-b106-46bb-b499-fd9cf4b5f0f6', '2023-04-02T07:43:12Z',
        'Bypass Ileum to Cecum, Via Natural or Artificial Opening Endoscopic', 'EXPLANATION',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 9, 3, '8c5d12d4-1b89-484b-a85d-7108a8065cc6');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('bb45b849-d4a2-4bed-9d7d-13ae8a506666', '2023-03-28T08:43:12Z',
        'Fluoroscopy of Intracranial Sinuses using Other Contrast', 'EXPLANATION',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 0, 3, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('3bcd9635-75cf-422d-b2b0-208e7bd91811', '2023-04-10T18:00:16Z',
        'Excision of Intracranial Artery, Open Approach', 'REFERENCE', '17fceead-5938-493b-b4b9-14726f2ddd9f', 6, 3,
        '401c0722-6032-4228-a0ca-e830695a414c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d95151e6-c494-4f9e-9eb8-3262d0402067', '2023-04-07T19:57:56Z',
        'Removal of Drainage Device from Upper Tendon, Open Approach', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 10, 1, 'bc806e1a-d3ed-4381-90f0-45e5408788bd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6f4f4b40-91f0-46fa-88df-8e7431e7c368', '2023-04-08T07:18:52Z',
        'Bypass Right Hepatic Duct to Left Hepatic Duct with Intraluminal Device, Open Approach', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 6, 1, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d89e271b-565d-41e5-94e8-694f58542058', '2023-04-05T17:59:35Z',
        'Excision of Right Lacrimal Bone, Percutaneous Approach, Diagnostic', 'REFERENCE',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 9, 1, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('be53462e-18d1-48ec-8b42-8c2c301ed83e', '2023-03-29T01:07:15Z',
        'Insertion of Internal Fixation Device into Right Temporal Bone, Open Approach', 'REFERENCE',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 0, 0, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b6858d8c-b720-4b7a-9048-861d08fcb2a2', '2023-03-25T11:50:01Z',
        'Dilation of Left Common Carotid Artery, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 10, 3, '358493e2-7b47-466a-9577-5fe67b2357bf');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('37de3ba7-b49b-4dcc-a714-bbfa9fb33714', '2023-03-15T08:05:24Z',
        'Revision of Autologous Tissue Substitute in Left Eye, Percutaneous Approach', 'REFERENCE',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 5, 0, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f51d5f81-ca5e-47e6-b6cb-b1bfc71063b0', '2023-04-13T03:44:49Z',
        'Reposition Sacrococcygeal Joint, External Approach', 'REFERENCE', '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 3, 2,
        'f778b158-c4eb-4b37-a57c-9c6576392318');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a140f8e0-b2e0-4fcc-9561-6ed811395c3e', '2023-03-02T03:40:01Z', 'Release Left Pleura, Open Approach',
        'REFERENCE', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 3, 0, '11b5d66f-a157-40f5-8b8a-924026b1ed01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b9437ef7-962c-41b8-8d1b-bedcb006ef8a', '2023-04-03T19:48:45Z',
        'Revision of Autologous Tissue Substitute in Omentum, Percutaneous Approach', 'EXPLANATION',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 3, 2, '133f9b65-1fe0-4a58-bda8-aa218eb5fa22');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8677ca59-db60-4218-95d3-e4f269e16855', '2023-03-31T14:24:46Z',
        'Removal of Drainage Device from Male Perineum, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '8352cf45-e8cc-4e09-8548-785723e941cb', 5, 3, '48661b6e-f1bc-4566-ad75-4419cda8256c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f64e497a-d722-46c9-a6cd-db3d2fefcb9f', '2023-04-24T02:19:26Z',
        'Dilation of Right Axillary Artery with Drug-eluting Intraluminal Device, Percutaneous Endoscopic Approach',
        'EXPLANATION', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 7, 1, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8177b44c-1679-44c6-9f8a-3ec6a7ff61c2', '2023-04-27T04:16:39Z',
        'Drainage of Hepatic Artery with Drainage Device, Open Approach', 'EXPLANATION',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 6, 3, '6d2dc4cb-5594-4bd6-b6b3-3a025622e8de');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('eb1ce166-f336-48db-ac20-f7c84688969e', '2023-04-07T03:04:46Z',
        'Release Left Foot Muscle, Percutaneous Endoscopic Approach', 'REFERENCE',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 1, 2, 'da30c55b-4df6-42e0-8466-dde1caf96546');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c634e34b-f527-4bcf-8a24-82a66b1e2f2c', '2023-03-04T02:33:10Z',
        'Insertion of Infusion Device into Right Sacroiliac Joint, Open Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 9, 1, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e5f996a5-1759-4145-aa0c-3f352c668309', '2023-04-19T12:13:32Z', 'Dilation of Small Intestine, Open Approach',
        'REFERENCE', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 10, 2, '24948bee-0d2b-4b88-8e2b-3597b3759653');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8c7479ee-ccac-4f89-ba50-5546dce90521', '2023-04-14T04:53:36Z',
        'Transfer Peroneal Nerve to Sciatic Nerve, Open Approach', 'REFERENCE', '44d588b6-5872-4c10-972d-8ac6e470f330',
        9, 1, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('da3aff7d-b438-48bf-b859-1279d4469264', '2023-04-29T01:56:05Z',
        'Plain Radiography of Superior Mesenteric Artery using High Osmolar Contrast', 'EXPLANATION',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 6, 3, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('cea1d65f-df1b-4671-9af9-b53bce6bf810', '2023-03-14T09:53:55Z',
        'Drainage of Inferior Vena Cava, Percutaneous Approach, Diagnostic', 'EXPLANATION',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 5, 2, 'da30c55b-4df6-42e0-8466-dde1caf96546');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9ed48231-c4bb-440f-bec4-a1de2dc72e1e', '2023-03-09T19:33:50Z',
        'Dilation of Esophagogastric Junction with Intraluminal Device, Via Natural or Artificial Opening Endoscopic',
        'REFERENCE', '4c94f5f1-34c9-4d59-b558-06b83563713b', 4, 1, '32669a4d-22e3-4a78-8988-b4ecbe30a1ab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('80549053-62ed-45c1-a9d8-54890db43046', '2023-04-04T21:54:06Z',
        'Insertion of Other Device into Right Buttock, Percutaneous Approach', 'EXPLANATION',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 3, 3, '0a2c770a-e96f-43af-87b9-5fa93d63ffe7');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('fbdfd011-bd6a-46b8-938b-8b7549b6f637', '2023-03-04T04:03:35Z',
        'Supplement Left Elbow Joint with Nonautologous Tissue Substitute, Percutaneous Approach', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 8, 0, '401c0722-6032-4228-a0ca-e830695a414c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a143b5c4-cbb7-4aca-871c-5072bde9e0fd', '2023-03-07T16:57:08Z',
        'Restriction of Right Common Carotid Artery with Intraluminal Device, Percutaneous Endoscopic Approach',
        'EXPLANATION', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 3, 3, 'a7201936-3e7f-4b99-9d61-b09ee15d59fb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('eba22c9c-b5a5-4165-beef-239976a7d5a5', '2023-04-11T11:24:04Z',
        'Supplement Bilateral Breast with Synthetic Substitute, External Approach', 'REFERENCE',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 6, 2, '1a803a5d-c939-4146-9f6c-19ea5555517b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1fda0cc7-a94c-4e02-9a48-a04a8762df85', '2023-03-03T13:21:59Z',
        'Revision of Drainage Device in Peritoneum, Percutaneous Approach', 'EXPLANATION',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 5, 1, 'd1820f16-13ef-4e63-a13a-23e40eb9d3a0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a71e1c8e-aa7f-456a-89b1-aba3a2b30ec6', '2023-03-10T18:08:21Z',
        'Excision of Common Bile Duct, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 9, 0, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('fffb2ef4-e5b1-4321-b397-bf4c9452dd59', '2023-04-12T23:29:37Z',
        'Fluoroscopy of Multiple Coronary Artery Bypass Grafts using High Osmolar Contrast', 'EXPLANATION',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 10, 2, '8ae8afad-8c17-497c-807a-0a0ce3626fb0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1fa8bac1-dfba-4f9d-9338-4cc955ab3973', '2023-03-08T15:40:48Z',
        'Fusion of Thoracic Vertebral Joint with Synthetic Substitute, Anterior Approach, Anterior Column, Percutaneous Endoscopic Approach',
        'EXPLANATION', '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 10, 1, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('eb3fca7b-3a80-4e18-a96f-57e029e561d6', '2023-03-31T05:08:01Z',
        'Transfer Left Thorax Muscle, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '8352cf45-e8cc-4e09-8548-785723e941cb', 5, 2, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1e33cbb1-1fa5-4a7a-a7b3-f954fdb31b3c', '2023-03-15T16:46:24Z',
        'Extirpation of Matter from Greater Omentum, Open Approach', 'EXPLANATION',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 6, 1, '80bcd2ee-3cf1-4b3e-9b2e-927840840c8d');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5c7f0af1-1019-4049-ad70-fecedb9419bb', '2023-04-20T21:24:21Z',
        'Replacement of Right Foot Artery with Nonautologous Tissue Substitute, Open Approach', 'EXPLANATION',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 10, 0, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('05a574a0-dd97-4f55-9af6-499b0252a02a', '2023-04-19T22:42:55Z',
        'Drainage of Cervical Spinal Cord, Open Approach', 'EXPLANATION', 'fc5ef255-21bf-4552-9f58-dc97efac45df', 8, 0,
        '7449d121-31ee-4789-91ca-e2e740e92067');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('31a7a1be-736f-497a-a7ac-d60f54436ebf', '2023-03-02T06:17:09Z',
        'Revision of Monitoring Device in Pancreatic Duct, Via Natural or Artificial Opening Endoscopic', 'EXPLANATION',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 10, 2, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b04c3a1a-c4a8-4e86-903e-dc27a96ad3f6', '2023-04-22T17:50:13Z',
        'Bypass Right Ventricle to Right Pulmonary Artery with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', '8352cf45-e8cc-4e09-8548-785723e941cb', 1, 1, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5fab4520-0bc8-4bbf-b6a1-c1c354759ee6', '2023-04-09T17:17:58Z', 'Bursae and Ligaments, Transfer', 'REFERENCE',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 1, 3, 'f778b158-c4eb-4b37-a57c-9c6576392318');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6bba9674-09b7-480e-b423-5ea716115b79', '2023-04-17T04:44:38Z',
        'Beam Radiation of Neck Skin using Photons <1 MeV', 'EXPLANATION', '6dd5008f-039d-4318-9c47-36742447e078', 3, 1,
        '8c5d12d4-1b89-484b-a85d-7108a8065cc6');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5aec8e2b-236a-4b88-b9a3-bc92fcd1c8f8', '2023-04-11T23:30:16Z', 'Change Splint on Left Hand', 'REFERENCE',
        'f79eee59-f187-49b3-a204-17c7e361573c', 3, 0, 'da30c55b-4df6-42e0-8466-dde1caf96546');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('463e531a-6fda-4325-af4f-7bf23b6efca3', '2023-03-24T20:29:51Z',
        'Resection of Right Tympanic Membrane, Via Natural or Artificial Opening Endoscopic', 'EXPLANATION',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 5, 1, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('47b8ace3-b14f-4ec1-905f-b0ae8f55c033', '2023-04-09T19:08:32Z',
        'Supplement Left Radial Artery with Autologous Tissue Substitute, Percutaneous Approach', 'EXPLANATION',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 8, 3, '401c0722-6032-4228-a0ca-e830695a414c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('17ba9bdd-472e-4c57-a9a9-f5660317be69', '2023-04-15T01:36:32Z',
        'Repair Lung Lingula, Via Natural or Artificial Opening', 'EXPLANATION', 'fc5ef255-21bf-4552-9f58-dc97efac45df',
        9, 1, '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b716bbf6-2879-4479-91fb-debdae9ee580', '2023-03-01T00:42:01Z',
        'Revision of Monitoring Device in Pancreatic Duct, Open Approach', 'REFERENCE',
        'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 9, 1, '2f5f35fa-2a39-449b-ab62-5d6fa62eac2f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('2ea2f2d1-4eca-439e-b760-0de21497aee7', '2023-03-24T08:55:56Z',
        'Insertion of Internal Fixation Device into Left Glenoid Cavity, Percutaneous Approach', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 1, 0, 'd1820f16-13ef-4e63-a13a-23e40eb9d3a0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f1386a1c-7fca-4763-b807-e249fe683aba', '2023-04-11T03:54:27Z',
        'Destruction of Accessory Sinus, Percutaneous Endoscopic Approach', 'REFERENCE',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 1, 1, '80bcd2ee-3cf1-4b3e-9b2e-927840840c8d');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('08eeb99b-9490-4607-8e62-4f6c75eae65c', '2023-04-14T23:52:56Z', 'Release Sacral Plexus, Open Approach',
        'REFERENCE', '17fceead-5938-493b-b4b9-14726f2ddd9f', 2, 0, '133f9b65-1fe0-4a58-bda8-aa218eb5fa22');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e1cbca94-8eff-44b2-b4e0-7791a6695013', '2023-04-28T22:29:45Z',
        'Removal of Drainage Device from Female Perineum, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 5, 0, '25795c0b-9ae0-4302-af55-e14074184821');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('93c421a9-f1db-4d84-aab1-0500f728d91b', '2023-03-06T06:01:04Z',
        'Restriction of Left Axillary Artery with Intraluminal Device, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'a2202602-438a-4657-a7c3-9027726c85cc', 7, 1, 'a7201936-3e7f-4b99-9d61-b09ee15d59fb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d50905ce-4683-48bf-8440-2fbd546b52e1', '2023-04-29T03:05:25Z',
        'Introduction of Radioactive Substance into Nose, Via Natural or Artificial Opening', 'REFERENCE',
        'a2202602-438a-4657-a7c3-9027726c85cc', 1, 1, 'f778b158-c4eb-4b37-a57c-9c6576392318');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('cd4a9077-84ea-4ce2-ae2e-96935d2f39ef', '2023-04-22T05:24:40Z',
        'Inspection of Left Inner Ear, External Approach', 'REFERENCE', '4c94f5f1-34c9-4d59-b558-06b83563713b', 8, 2,
        '35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a239b078-345b-4d3c-b244-901e3188aea9', '2023-04-26T16:20:45Z',
        'Restriction of Trachea with Extraluminal Device, Percutaneous Endoscopic Approach', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 4, 1, '96e04c30-cbda-4fa1-9956-e0557a2329cb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('dea537af-f70c-4e1f-b3ce-389071c5ce85', '2023-03-04T09:27:20Z',
        'Inspection of Left Metacarpocarpal Joint, Open Approach', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 6, 3, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('de662651-d154-4f77-af43-f5cbbe63d6aa', '2023-03-11T23:18:43Z',
        'Removal of Internal Fixation Device from Right Knee Joint, Open Approach', 'EXPLANATION',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 3, 3, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('00b5b925-639d-4040-8d16-3f5f5480d352', '2023-04-24T15:21:56Z', 'Reposition Coccyx, External Approach',
        'EXPLANATION', 'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 6, 3, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('5da2b13f-8481-4e0f-ba1c-eccbda611b80', '2023-04-13T16:47:41Z', 'Respiratory System, Transplantation',
        'EXPLANATION', '4888af09-3445-418e-87ca-67f7da19583e', 6, 0, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d7af94fb-7d2b-4227-aaa2-966805c45fe9', '2023-04-15T06:53:18Z',
        'Release Left Lower Lobe Bronchus, Via Natural or Artificial Opening Endoscopic', 'REFERENCE',
        'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 4, 3, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('68a6dbe3-383d-44b1-8ea6-dbba12174ea5', '2023-04-21T18:13:16Z',
        'Bypass Left Axillary Artery to Left Lower Leg Artery with Nonautologous Tissue Substitute, Open Approach',
        'EXPLANATION', 'f79eee59-f187-49b3-a204-17c7e361573c', 5, 1, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b02ce1bf-a322-4065-8785-fbcce415dfd7', '2023-03-28T06:15:08Z',
        'Insertion of Defibrillator Lead into Left Ventricle, Percutaneous Endoscopic Approach', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 8, 0, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('65c84430-563c-48cd-af8e-03965ffd151e', '2023-04-19T22:39:34Z',
        'Bypass Left Vas Deferens to Left Vas Deferens, Percutaneous Endoscopic Approach', 'REFERENCE',
        '4888af09-3445-418e-87ca-67f7da19583e', 0, 0, '25795c0b-9ae0-4302-af55-e14074184821');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f5a5c078-826c-4e2f-9248-acdec8415cd7', '2023-03-29T21:59:21Z',
        'Revision of Autologous Tissue Substitute in Left Tarsal Joint, Percutaneous Approach', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 3, 1, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('cc2d2097-9546-487d-bfe8-4ddc50e93fe7', '2023-04-16T01:32:26Z',
        'Extirpation of Matter from Left Trunk Muscle, Percutaneous Approach', 'REFERENCE',
        'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 5, 1, '20d81ca4-8961-49d0-b30e-3e4ee8b30834');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a88151ff-6e81-4244-bb69-4d3aa6d65de4', '2023-03-07T10:13:01Z',
        'Dilation of Left Renal Vein, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 7, 2, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7a5e9642-6580-45d3-8ac9-523c0c423818', '2023-03-12T06:36:28Z',
        'Drainage of Ileocecal Valve with Drainage Device, Percutaneous Approach', 'REFERENCE',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 0, 1, '7b57ffdd-6ff8-4fb0-b5b9-38d8ac32968f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('cc288c15-53bc-4997-ba8a-c94a7a8e6010', '2023-04-12T05:09:41Z',
        'Revision of Intraluminal Device in Trachea, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '6dd5008f-039d-4318-9c47-36742447e078', 7, 1, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8de8ec11-4056-4e66-b8ef-60d1d0a9120a', '2023-03-03T12:20:18Z',
        'Replacement of Right Humeral Head with Nonautologous Tissue Substitute, Percutaneous Approach', 'EXPLANATION',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 0, 1, '24948bee-0d2b-4b88-8e2b-3597b3759653');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('97582c9c-2f97-4bff-a88c-6129bece8892', '2023-04-29T11:41:12Z',
        'Reposition Thoracic Aorta, Descending, Open Approach', 'REFERENCE', '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 2,
        3, '96e04c30-cbda-4fa1-9956-e0557a2329cb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('4c03e689-5253-45e4-a79b-361c3691eb6d', '2023-03-27T15:59:53Z', 'Repair Cisterna Chyli, Percutaneous Approach',
        'EXPLANATION', 'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 0, 1, '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('18a86936-aa1d-49f2-ba50-5a879ff98406', '2023-03-16T08:14:39Z',
        'Supplement Left Brachial Vein with Nonautologous Tissue Substitute, Percutaneous Endoscopic Approach',
        'EXPLANATION', '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 8, 1, '8ae8afad-8c17-497c-807a-0a0ce3626fb0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f3ab62e2-4344-4f8d-9281-2124ce538ded', '2023-04-14T01:53:21Z',
        'Transfer Oculomotor Nerve to Optic Nerve, Percutaneous Endoscopic Approach', 'REFERENCE',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 1, 3, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('da7acf1c-cfe0-4179-9c1d-623581c996fa', '2023-04-02T15:58:01Z',
        'Dilation of Right Brachial Vein with Intraluminal Device, Open Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 7, 2, 'be760e90-8eba-464c-bc7b-7ae5577cbe83');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7007c2f7-b473-40b0-8124-7b245b4a7516', '2023-03-24T14:18:40Z', 'Static Orthosis Device Fitting using Orthosis',
        'EXPLANATION', '8352cf45-e8cc-4e09-8548-785723e941cb', 5, 0, '5f6f0cf7-1106-44ec-b806-e9ed4b490f8b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('53b462fd-4dfb-434b-9068-9a72cf418d39', '2023-03-04T07:35:05Z',
        'Irrigation of Lower GI using Irrigating Substance, Via Natural or Artificial Opening', 'EXPLANATION',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 1, 0, '3215a35b-8596-44e3-9ec7-e112c8412b2e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7f35cc5e-7943-46c0-90d3-2a17e2a8fac7', '2023-04-09T19:45:47Z',
        'Repair Right Ethmoid Bone, Percutaneous Endoscopic Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 5, 1, '48661b6e-f1bc-4566-ad75-4419cda8256c');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('95fe5d4c-5929-4243-a773-d10fc6a30004', '2023-04-02T14:27:25Z',
        'Replacement of Right Temporal Bone with Nonautologous Tissue Substitute, Open Approach', 'EXPLANATION',
        '9f9cc050-5c09-4059-bdc1-01a639a0cfab', 3, 3, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('3ad12ad2-53f3-459f-9409-597e41c6f5c4', '2023-03-01T05:45:18Z',
        'Bypass Innominate Artery to Bilateral Upper Leg Artery, Open Approach', 'EXPLANATION',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 1, 3, '4e92b433-3020-45ad-bebc-fa4c973e39bc');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('eacbcdb4-6c99-412e-ac2c-439b2f9e8425', '2023-03-23T16:40:42Z',
        'Introduction of Other Antineoplastic into Mouth and Pharynx, Percutaneous Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 7, 1, '358493e2-7b47-466a-9577-5fe67b2357bf');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b4b3173b-b389-4752-8d04-99f1333a27ff', '2023-04-24T00:13:03Z',
        'Beam Radiation of Spleen using Heavy Particles (Protons,Ions)', 'REFERENCE',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 9, 2, '71170f26-d3bf-47e6-ac66-7a7a09fe3f0f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('ad734e96-226e-4a50-aaf1-360df8ebcd0a', '2023-04-22T01:12:35Z',
        'Plain Radiography of Left Ankle using High Osmolar Contrast', 'REFERENCE',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 10, 1, '133f9b65-1fe0-4a58-bda8-aa218eb5fa22');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f737baa6-33f2-4188-83f0-21a55a98dbc0', '2023-04-19T22:23:10Z',
        'Drainage of Right Knee Region, Percutaneous Approach', 'REFERENCE', 'e1dc7c97-540a-4788-92b3-a01b40cf0f11', 3,
        0, '32669a4d-22e3-4a78-8988-b4ecbe30a1ab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8ea9c4bb-46de-4843-883d-7a2259099b7d', '2023-04-11T21:59:31Z',
        'Drainage of Right Internal Jugular Vein with Drainage Device, Open Approach', 'EXPLANATION',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 2, 3, '11b5d66f-a157-40f5-8b8a-924026b1ed01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c63324f2-ce6d-48a6-ae12-2896e1edcb91', '2023-03-20T01:20:25Z',
        'Destruction of Right Axillary Vein, Open Approach', 'REFERENCE', '4c94f5f1-34c9-4d59-b558-06b83563713b', 1, 0,
        '29b0f439-0efe-4747-a4d7-f985f3dbed77');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('a4dbd117-618a-4b9b-b5b2-175b4fee5f69', '2023-03-18T02:58:02Z',
        'Drainage of Cerebral Meninges, Percutaneous Approach, Diagnostic', 'REFERENCE',
        '6dd5008f-039d-4318-9c47-36742447e078', 9, 3, 'de86cbcf-6fd8-49d0-a5cb-305fcc4820f1');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('b364b472-517c-44e1-830b-aa7189d21a27', '2023-03-25T09:15:04Z',
        'Revision of Drainage Device in Lower Bone, Open Approach', 'EXPLANATION',
        'a2202602-438a-4657-a7c3-9027726c85cc', 3, 1, '0a2c770a-e96f-43af-87b9-5fa93d63ffe7');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e328c8d6-73be-459a-8de3-4419e82ad781', '2023-03-01T09:19:05Z',
        'Removal of Radioactive Element from Left Lung, Via Natural or Artificial Opening', 'EXPLANATION',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 4, 3, 'a87795cf-c746-493e-8f93-d3d8502848b2');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('36c68cf1-7f44-4f09-92bd-7ea14bde6f0a', '2023-04-28T17:23:22Z',
        'Release Right Upper Arm Subcutaneous Tissue and Fascia, Percutaneous Approach', 'REFERENCE',
        '4888af09-3445-418e-87ca-67f7da19583e', 1, 1, '82b5e725-6ea9-421b-91a7-2704f7982ed3');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('ab7975f5-3cda-4cdb-9b83-d4b921bbb482', '2023-04-12T00:32:30Z',
        'Removal of Extraluminal Device from Right Eye, Via Natural or Artificial Opening Endoscopic', 'REFERENCE',
        '68e62c31-fcd9-4d00-8859-1f34c629ccec', 9, 2, '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6d00f11e-dc9e-4f1b-bfea-59fbe5c55cb8', '2023-03-13T00:37:32Z',
        'Fusion of Occipital-cervical Joint with Synthetic Substitute, Posterior Approach, Posterior Column, Open Approach',
        'EXPLANATION', 'a2202602-438a-4657-a7c3-9027726c85cc', 2, 3, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f1b15b38-4a0e-4a81-81a8-1d3f9ed00179', '2023-03-27T10:36:37Z',
        'Low Dose Rate (LDR) Brachytherapy of Kidney using Other Isotope', 'EXPLANATION',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 5, 2, '1f62b387-9277-4456-ab31-0e1cbb7488c0');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('3357b3f9-94c3-490d-af32-a272b3e4be02', '2023-03-28T08:56:23Z', 'Release Right Cephalic Vein, Open Approach',
        'REFERENCE', 'eba25bb4-9ccc-43e6-8792-b0b1c478ea28', 5, 3, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('dd1f2e41-cb8f-4d78-b81f-426c38411df2', '2023-04-23T15:11:33Z',
        'Removal of Autologous Tissue Substitute from Facial Bone, Percutaneous Endoscopic Approach', 'REFERENCE',
        'b9fd8643-2112-494d-bd34-01e8cc0d5b7a', 2, 0, '2f5f35fa-2a39-449b-ab62-5d6fa62eac2f');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('859435e5-1892-4d97-8c0b-01640b6885c2', '2023-04-09T20:53:25Z',
        'Supplement Esophageal Vein with Autologous Tissue Substitute, Percutaneous Endoscopic Approach', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 0, 2, 'da30c55b-4df6-42e0-8466-dde1caf96546');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('0feeb4ec-088a-459b-91e2-5e65373763a3', '2023-04-12T15:35:18Z',
        'Introduction of Anti-inflammatory into Joints, Percutaneous Approach', 'REFERENCE',
        'bd9d67a2-57ee-4564-b9a6-e82db487b4eb', 8, 0, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('210c5d0e-c44f-4f7b-bae2-41f5ba4b90f8', '2023-03-05T09:28:20Z',
        'Destruction of Lumbosacral Disc, Percutaneous Approach', 'EXPLANATION', '44d588b6-5872-4c10-972d-8ac6e470f330',
        7, 2, '35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('393455b8-5c0f-4540-bf98-56c750cd4c66', '2023-03-04T04:03:40Z',
        'Removal of Nonautologous Tissue Substitute from Mesentery, Percutaneous Approach', 'REFERENCE',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 0, 3, '0f7f13c3-dc9e-4fb5-9578-84668f803a19');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f73bfcc6-45c6-49a6-b80b-e9d34c2620af', '2023-04-15T20:14:46Z',
        'Inspection of Hepatobiliary Duct, Via Natural or Artificial Opening', 'REFERENCE',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 0, 0, '6bff9d94-fa7e-4aab-a2ad-2b07273939e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1b272f43-3093-4201-a0a0-dad7ab01f3f0', '2023-03-26T02:16:31Z',
        'Replacement of Gastric Vein with Synthetic Substitute, Open Approach', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 0, 3, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('1e0bd9d3-8ca7-49cf-b351-edde96b00f1b', '2023-03-03T05:39:48Z',
        'Supplement Right Carpal with Autologous Tissue Substitute, Percutaneous Approach', 'EXPLANATION',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 10, 3, '0a2c770a-e96f-43af-87b9-5fa93d63ffe7');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('4c402451-6a6a-43de-a736-c0a91f97143a', '2023-04-20T19:04:59Z',
        'Bypass Ileum to Rectum with Autologous Tissue Substitute, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 0, 1, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('eee66f97-8898-450e-9247-a7d2390c3dfd', '2023-04-15T21:36:58Z',
        'Drainage of Left Knee Tendon with Drainage Device, Percutaneous Endoscopic Approach', 'REFERENCE',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 4, 1, '5f6f0cf7-1106-44ec-b806-e9ed4b490f8b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('dcaa1906-a0bc-464c-9ca4-ef1d991273aa', '2023-04-25T15:30:45Z',
        'Removal of Autologous Tissue Substitute from Coccyx, Percutaneous Approach', 'EXPLANATION',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 0, 2, '9f53d7be-4f16-4666-9c06-655610aabf85');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('88a54b41-0fb3-4b56-9abc-a9f95c0c3a89', '2023-03-10T11:42:06Z',
        'Supplement Right Brachial Artery with Nonautologous Tissue Substitute, Open Approach', 'REFERENCE',
        '4888af09-3445-418e-87ca-67f7da19583e', 7, 0, '5f6f0cf7-1106-44ec-b806-e9ed4b490f8b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('db751872-81f8-43f8-8e6a-cf7f939231d3', '2023-03-30T15:00:01Z',
        'High Dose Rate (HDR) Brachytherapy of Ureter using Iodine 125 (I-125)', 'REFERENCE',
        '42e82e97-cac8-4253-9a7e-8e812cddcfd9', 2, 0, 'e1199a0e-1c7f-49a9-a8f0-521922133413');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('d461d2b9-3cfa-4287-aca3-fd6b845b2802', '2023-04-24T06:11:50Z',
        'Beam Radiation of Axillary Lymphatics using Heavy Particles (Protons,Ions)', 'EXPLANATION',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 9, 0, '11b5d66f-a157-40f5-8b8a-924026b1ed01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('72c78183-53e4-48b5-8799-1ed33c12951f', '2023-04-23T17:14:04Z',
        'Supplement Facial Nerve with Autologous Tissue Substitute, Percutaneous Approach', 'REFERENCE',
        '6b3b8617-fbbf-4c91-b83d-f1a42d621c3e', 3, 2, '96e04c30-cbda-4fa1-9956-e0557a2329cb');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e9d12dba-ea1b-4cd1-840e-255fdea4a16e', '2023-04-20T04:43:22Z',
        'Excision of Left Greater Saphenous Vein, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'f79eee59-f187-49b3-a204-17c7e361573c', 9, 0, '9c240f98-9306-4a0e-bc61-191775c9ad58');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c5aa017b-8eb0-4526-a9c2-8ba3b69819a8', '2023-03-23T10:49:44Z',
        'Insertion of Infusion Device into Vagina and Cul-de-sac, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'ac7d494a-60b5-4ef6-bb1a-1550c28d1dc9', 4, 1, '1a803a5d-c939-4146-9f6c-19ea5555517b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e0cb66d9-531a-4a1f-952a-0c0b9bebc00d', '2023-03-22T05:09:51Z',
        'Introduction of Anti-inflammatory into Upper GI, Via Natural or Artificial Opening Endoscopic', 'REFERENCE',
        '44d588b6-5872-4c10-972d-8ac6e470f330', 3, 1, '5f6f0cf7-1106-44ec-b806-e9ed4b490f8b');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('187531a3-b517-46bb-8edb-d98a929190b9', '2023-03-06T01:17:15Z',
        'Replacement of Lower Tooth, All, with Synthetic Substitute, Open Approach', 'REFERENCE',
        '6dd5008f-039d-4318-9c47-36742447e078', 7, 3, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('9560d13c-0a57-495d-ac37-eb7cf009c9f0', '2023-04-03T13:28:33Z',
        'Reposition Left Elbow Joint, Percutaneous Approach', 'REFERENCE', '68e62c31-fcd9-4d00-8859-1f34c629ccec', 5, 3,
        '429dcd3b-0bfd-4909-a243-93e81a9cdc01');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('14c44b73-c7e9-448f-ad61-6eddd165d679', '2023-03-19T16:14:33Z',
        'Removal of Internal Fixation Device from Thoracolumbar Vertebral Joint, Open Approach', 'EXPLANATION',
        '8352cf45-e8cc-4e09-8548-785723e941cb', 10, 1, '8c5d12d4-1b89-484b-a85d-7108a8065cc6');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('81d4b38f-ff6a-44a6-b6fd-629e1e21233d', '2023-04-15T14:54:53Z',
        'Replacement of Right Ulna with Synthetic Substitute, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'fc5ef255-21bf-4552-9f58-dc97efac45df', 2, 2, '35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('e9f0f6ce-8b86-4fb6-bea1-5c3fb7ba8743', '2023-03-15T10:10:57Z',
        'Drainage of Right Internal Carotid Artery with Drainage Device, Percutaneous Approach', 'EXPLANATION',
        '4888af09-3445-418e-87ca-67f7da19583e', 1, 0, '97e98c5c-8787-49b6-99a1-9e7a8db84d5e');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('f720078b-e1b8-472d-b4a3-aba5388f275f', '2023-03-04T12:45:02Z', 'Destruction of Facial Muscle, Open Approach',
        'REFERENCE', 'fd00a796-ac46-4978-9764-38eb226d4f55', 7, 3, '113ec8a1-8b64-44e8-914a-54fb75a9f2dd');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('fe879bc0-e5a1-4a40-b559-074387c4f58c', '2023-03-23T05:11:24Z',
        'Removal of Synthetic Substitute from Upper Tendon, Open Approach', 'REFERENCE',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 7, 0, '32669a4d-22e3-4a78-8988-b4ecbe30a1ab');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('c8de19ba-3d97-4896-ad4d-1ad2cf46f7b0', '2023-03-31T12:44:21Z',
        'Destruction of Right Upper Leg Tendon, Percutaneous Endoscopic Approach', 'EXPLANATION',
        'fd00a796-ac46-4978-9764-38eb226d4f55', 7, 0, 'ab8e13a3-951e-4f33-9ef4-144d107965a5');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('829a2eff-934b-4afc-9fea-d54db32e2647', '2023-03-30T12:42:50Z',
        'Revision of Drainage Device in Peritoneum, Percutaneous Approach', 'REFERENCE',
        '17fceead-5938-493b-b4b9-14726f2ddd9f', 0, 3, '35aaacf5-b2e9-42ba-afa0-599ff1ed8fc4');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('8bca2cb5-8fa4-4dc6-bf36-50041d6d6f67', '2023-04-20T00:59:37Z',
        'Insertion of External Fixation Device into Left Knee Joint, Percutaneous Endoscopic Approach', 'EXPLANATION',
        '7a3cf7d6-b3fc-4313-9880-9dcabd3497eb', 8, 0, '18d4b2de-e35a-47c8-bda4-2bc4fe6f3f89');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('aa359255-6267-4494-ab1f-ee2255293a40', '2023-04-10T21:49:53Z',
        'Plain Radiography of Hepatic Artery using Low Osmolar Contrast', 'REFERENCE',
        '4c94f5f1-34c9-4d59-b558-06b83563713b', 4, 0, 'e1199a0e-1c7f-49a9-a8f0-521922133413');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('6a148d58-2d20-405d-b559-b8b983396226', '2023-03-13T23:18:55Z',
        'Bypass Jejunum to Transverse Colon, Open Approach', 'REFERENCE', '68e62c31-fcd9-4d00-8859-1f34c629ccec', 6, 0,
        '392a8d50-c44a-4f4c-ad15-81fc77c849e8');
insert into solutionz (id, creation_timestamp, content, category, created_by, vote_good_count, vote_bad_count,
                       problemz_id)
values ('7e8abc8c-47eb-4b1a-8091-804f5bf217a9', '2023-04-24T14:54:25Z',
        'Restriction of Bladder Neck, Via Natural or Artificial Opening Endoscopic', 'EXPLANATION',
        '6dd5008f-039d-4318-9c47-36742447e078', 3, 0, 'f778b158-c4eb-4b37-a57c-9c6576392318');
