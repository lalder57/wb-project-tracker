--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: thayn
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    student_github character varying(30),
    project_title character varying(30),
    grade integer
);


ALTER TABLE public.grades OWNER TO thayn;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: thayn
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grades_id_seq OWNER TO thayn;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: thayn
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: thayn
--

CREATE TABLE public.projects (
    title character varying(30) NOT NULL,
    description text,
    max_grade integer
);


ALTER TABLE public.projects OWNER TO thayn;

--
-- Name: students; Type: TABLE; Schema: public; Owner: thayn
--

CREATE TABLE public.students (
    github character varying(30) NOT NULL,
    first_name character varying(30),
    last_name character varying(30),
    cohort character varying(20)
);


ALTER TABLE public.students OWNER TO thayn;

--
-- Name: report_card_view; Type: VIEW; Schema: public; Owner: thayn
--

CREATE VIEW public.report_card_view AS
 SELECT students.first_name,
    students.last_name,
    projects.title,
    projects.max_grade,
    grades.grade
   FROM ((public.students
     JOIN public.grades ON (((students.github)::text = (grades.student_github)::text)))
     JOIN public.projects ON (((projects.title)::text = (grades.project_title)::text)));


ALTER VIEW public.report_card_view OWNER TO thayn;

--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: thayn
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: thayn
--

COPY public.grades (id, student_github, project_title, grade) FROM stdin;
1	jhacks	Markov	10
2	jhacks	Blockly	2
3	sdevelops	Markov	50
4	sdevelops	Blockly	100
5	jhacks	JavaScript	50
6	sdevelops	JavaScript	75
7	jhacks	React	70
8	sdevelops	React	100
9	jhacks	SQL	20
10	sdevelops	SQL	50
11	jhacks	CSS	15
12	sdevelops	CSS	25
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: thayn
--

COPY public.projects (title, description, max_grade) FROM stdin;
Markov	Tweets generated from Markov chains	50
Blockly	Programmatic Logic Puzzle Game	100
JavaScript	Code challenges	75
React	JavaScript and HTML	100
SQL	Practice querying databases	50
CSS	Some styling techniques	25
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: thayn
--

COPY public.students (github, first_name, last_name, cohort) FROM stdin;
jhacks	Jane	Hacker	Fall 2024
sdevelops	Sarah	Developer	Spring 2025
\.


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: thayn
--

SELECT pg_catalog.setval('public.grades_id_seq', 13, true);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: thayn
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: thayn
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (title);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: thayn
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (github);


--
-- Name: grades grades_project_title_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thayn
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_project_title_fkey FOREIGN KEY (project_title) REFERENCES public.projects(title);


--
-- Name: grades grades_student_github_fkey; Type: FK CONSTRAINT; Schema: public; Owner: thayn
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_student_github_fkey FOREIGN KEY (student_github) REFERENCES public.students(github);


--
-- PostgreSQL database dump complete
--

