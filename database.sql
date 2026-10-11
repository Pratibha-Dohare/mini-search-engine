-- Import this file INTO an existing database in phpMyAdmin.
-- InfinityFree creates the database first; this script only creates the table.
CREATE TABLE IF NOT EXISTS websites (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 title VARCHAR(160) NOT NULL,
 url VARCHAR(500) NOT NULL,
 description TEXT NOT NULL,
 keywords VARCHAR(500) NOT NULL,
 category VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO websites (title,url,description,keywords,category) VALUES
('Python','https://www.python.org/','Official Python programming language site, documentation and downloads.','python coding programming software learn','Programming'),
('MDN Web Docs','https://developer.mozilla.org/','Learn HTML, CSS, JavaScript and modern web development.','web development html css javascript learn coding','Development'),
('GitHub','https://github.com/','Host and collaborate on code repositories with Git version control.','git github coding software projects','Development'),
('Stack Overflow','https://stackoverflow.com/','Questions and answers for developers and programmers.','programming debugging answers coding','Development'),
('freeCodeCamp','https://www.freecodecamp.org/','Free interactive lessons in coding, web development and Python.','learn coding python javascript courses','Education'),
('Khan Academy','https://www.khanacademy.org/','Free lessons in mathematics, science and computing.','education math learn science courses','Education'),
('Coursera','https://www.coursera.org/','Online courses and certificates in data science, business and more.','education machine learning courses ai','Education'),
('edX','https://www.edx.org/','Online learning from universities and academic institutions.','education university coding courses','Education'),
('Wikipedia','https://www.wikipedia.org/','Free encyclopedia covering millions of topics.','encyclopedia research knowledge information','Reference'),
('Google Scholar','https://scholar.google.com/','Find research papers, academic articles and citations.','research academic science papers','Research'),
('arXiv','https://arxiv.org/','Open-access research preprints in AI, mathematics and computer science.','ai research paper machine learning deep learning','Research'),
('Hugging Face','https://huggingface.co/','Open models, datasets and tools for machine learning.','artificial intelligence ai machine learning models datasets','Artificial Intelligence'),
('PyTorch','https://pytorch.org/','Open-source deep learning framework for research and applications.','python ai deep learning neural networks','Artificial Intelligence'),
('TensorFlow','https://www.tensorflow.org/','End-to-end platform for building machine learning systems.','ai machine learning tensorflow python','Artificial Intelligence'),
('Kaggle','https://www.kaggle.com/','Datasets, notebooks and machine learning competitions.','data science datasets python ai competitions','Data Science'),
('Figma','https://www.figma.com/','Collaborative interface design and prototyping tool.','ui ux design website prototyping','Design'),
('Canva','https://www.canva.com/','Create graphics, presentations and social media designs.','design graphics templates visual','Design'),
('CSS-Tricks','https://css-tricks.com/','Guides and examples for CSS, layout and frontend interfaces.','css html web design frontend','Design');
