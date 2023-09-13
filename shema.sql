-- Create a table for the Genre class
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

-- Create a table for the Author class
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

-- Create a table for the Label class
CREATE TABLE labels (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL
);

-- Create a table for the Source class
CREATE TABLE sources (
    id SERIAL PRIMARY KEY,
    source_name VARCHAR(255) NOT NULL
);

-- Create a table for the Item class (Parent class)
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    genre_id INT REFERENCES genres(id),
    author_id INT REFERENCES authors(id),
    source_id INT REFERENCES sources(id),
    label_id INT REFERENCES labels(id),
    publish_date INT,
    archived BOOLEAN DEFAULT FALSE
);

-- Create a table for the Movie class (Child class of Item)
CREATE TABLE movies (
    item_id INT PRIMARY KEY REFERENCES items(id),
    silet BOOLEAN
);
