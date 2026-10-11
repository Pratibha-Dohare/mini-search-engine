<?php
declare(strict_types=1);
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

$q = trim((string) ($_GET['q'] ?? ''));
if ($q === '' || mb_strlen($q) > 100) {
    echo json_encode(['count' => 0, 'results' => []]);
    exit;
}

try {
    require __DIR__ . '/db.php';
    $pdo = new PDO("mysql:host={$DB_HOST};dbname={$DB_NAME};charset=utf8mb4", $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
    $words = preg_split('/\s+/u', $q, -1, PREG_SPLIT_NO_EMPTY);
    $words = array_slice($words, 0, 8);
    // Title weighted 5, keywords 3, description 1. Match any word.
    $parts = [];
    $params = [];
    $score = [];
    foreach ($words as $word) {
        $like = '%' . addcslashes($word, '%_\\') . '%';
        $parts[] = '(title LIKE ? OR keywords LIKE ? OR description LIKE ?)';
        array_push($params, $like, $like, $like);
        $score[] = '(CASE WHEN title LIKE ? THEN 5 ELSE 0 END + CASE WHEN keywords LIKE ? THEN 3 ELSE 0 END + CASE WHEN description LIKE ? THEN 1 ELSE 0 END)';
    }
    // Bind score parameters first because they occur before WHERE placeholders.
    $sql = 'SELECT title, url, description, category, (' . implode(' + ', $score) . ') AS relevance FROM websites WHERE ' . implode(' OR ', $parts) . ' ORDER BY relevance DESC, title ASC LIMIT 30';
    $stmt = $pdo->prepare($sql);
    $scoreParams = [];
    foreach ($words as $word) { $like = '%' . addcslashes($word, '%_\\') . '%'; array_push($scoreParams, $like, $like, $like); }
    $stmt->execute(array_merge($scoreParams, $params));
    $data = $stmt->fetchAll();
    foreach ($data as &$row) unset($row['relevance']);
    echo json_encode(['count' => count($data), 'results' => $data], JSON_UNESCAPED_SLASHES | JSON_INVALID_UTF8_SUBSTITUTE);
} catch (Throwable $e) {
    error_log('NovaSearch error: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Search service unavailable']);
}
