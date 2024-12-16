CREATE DATABASE PlateformeBlog;
USE PlateformeBlog;

-- Table des rôles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_role VARCHAR(50) NOT NULL
);

-- Insérer des rôles de base
INSERT INTO roles (nom_role) VALUES ('Utilisateur'), ('Administrateur');

-- Table utilisateurs
CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_utilisateur VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe_hash VARCHAR(255) NOT NULL,
    role_id INT DEFAULT 1,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL  -- role_id peut être NULL si le rôle est supprimé
);

-- Table tags
CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    modifie_le TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table articles
CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id INT NOT NULL,
    tags_id INT,
    titre VARCHAR(255) NOT NULL,
    contenu TEXT NOT NULL,
    Url_image VARCHAR(255),
    cree_le TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modifie_le TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id) ON DELETE CASCADE,  -- Suppression en cascade des utilisateurs
    FOREIGN KEY (tags_id) REFERENCES tags(id) ON DELETE SET NULL  -- La référence à tags peut être mise à NULL si le tag est supprimé
);

-- Table des commentaires
CREATE TABLE commentaires (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    utilisateur_id INT,
    contenu TEXT NOT NULL,
    cree_le TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modifie_le TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,  -- Suppression en cascade des articles
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id) ON DELETE SET NULL  -- La référence à l'utilisateur peut être mise à NULL si l'utilisateur est supprimé
);

-- Table many-to-many pour les articles et les tags
CREATE TABLE article_tags (
    article_id INT NOT NULL,
    tags_id INT NOT NULL,
    PRIMARY KEY (article_id, tags_id),
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,  -- Suppression en cascade des articles
    FOREIGN KEY (tags_id) REFERENCES tags(id) ON DELETE CASCADE  -- Suppression en cascade des tags
);

-- Table likes
CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id INT NOT NULL,
    article_id INT NOT NULL,
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id) ON DELETE CASCADE,  -- Suppression en cascade des utilisateurs
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE  -- Suppression en cascade des articles
);
