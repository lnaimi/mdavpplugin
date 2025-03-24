package code.plugin.vp.Structures.PIMParameterization;

import java.util.List;

public class ParameterizedUmlElement {

    private String Id;
    private String FullQualifiedName;
    private String Name;
    private String Type;
    private List<ParameterizedDesignConcern> DesignConcerns;
    //private String RelationDirection;//Needed to make diffrence between Relationships with same name 
    //private String ParentClass; //Needed to make diffrence between classes sub childs (attribute,..) 

    public ParameterizedUmlElement() {}

    public ParameterizedUmlElement(String parId, String parFullQualifiedName, String parName, String parType, List<ParameterizedDesignConcern> parDesignConcerns){
        this.Id = parId;
        this.FullQualifiedName = parFullQualifiedName;
        this.Name = parName;
        this.Type = parType;
        this.DesignConcerns = parDesignConcerns;
    }

    //Id
    public String getId() {
        return Id;
    }

    public void setId(String paraId) {
        this.Id = paraId;
    }

    //Full Qualified Name
    public String getFullQualifiedName() {
        return FullQualifiedName;
    }

    public void setFullQualifiedName(String paraFullQualifiedName) {
        this.FullQualifiedName = paraFullQualifiedName;
    }

    //Name
    public String getName() {
        return Name;
    }

    public void setName(String parName) {
        this.Name = parName;
    }

    //Type
    public String getType() {
        return Type;
    }

    public void setType(String paraType) {
        this.Type = paraType;
    }

    //Description
    public List<ParameterizedDesignConcern> getDesignConcerns() {
        return DesignConcerns;
    }

    public void setDesignConcerns(List<ParameterizedDesignConcern> paraDesignConcerns) {
        this.DesignConcerns = paraDesignConcerns;
    }

}