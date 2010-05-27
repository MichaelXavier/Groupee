namespace :data_mining do
  desc "Create a 1-mode user matrix"
  task :one_mode, :needs => [:environment] do
    directory "reports"
    outfile = File.join('reports', (ENV['OUTPUT'] or '1-mode-user.xls'))
    prog_msg("Generating one-mode matrix #{outfile}") do
      User.one_mode_matricize(outfile)
    end
  end

  #FIXME: refactor this somewhere so it can be shared?
private
  def prog_msg(msg, &blk)
    print "#{msg}..."
    blk.call
    puts "Done"
  end
end
