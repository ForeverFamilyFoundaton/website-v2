class UpdateAttachedFilesForRadioShows < ActiveRecord::Migration[6.0]
  def up
    AttachedFile.where(attachable_type: 'RadioArchive').update_all(
      attachable_type: 'RadioShow'
    )
    EmbededLink.where(em_linkable_type: 'RadioArchive').update_all(
      em_linkable_type: 'RadioShow'
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
