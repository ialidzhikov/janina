class CreateLeaderboard < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE VIEW leaderboard_records AS
      SELECT
        users.id AS user_id,
        users.full_name AS full_name,
        users.faculty_number AS faculty_number,
        COALESCE(SUM(solutions.points), 0) AS total_points
      FROM users
      LEFT JOIN solutions
      ON users.id = solutions.user_id
      WHERE users.admin = 'f'
      GROUP BY users.id
      ORDER BY total_points DESC;
    SQL
  end

  def down
    execute 'DROP VIEW leaderboard_records'
  end
end
